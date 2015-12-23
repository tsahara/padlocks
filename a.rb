#!/usr/bin/env ruby

require 'openssl'

def new_serial
  rand(2**32)
end

class CertUtils
  def self.mkcert(h={})
    h = {
      :rsa_key_length => 2048,
      :not_before => Time.now - 86400*30,
      :not_after  => Time.now + 86400*30,
      :hash_algorithm => :sha256
    }.merge(h)

    raise RuntimeError, ":cn is required (can be :none)" unless h[:cn]

    unless h[:self_signed] || (h[:ca_certificate] && h[:ca_key])
      raise RuntimeError, ":self_signed or :ca_certificate/:ca_key is required"
    end

    rsa = OpenSSL::PKey::RSA.generate h[:rsa_key_length]

    cert = OpenSSL::X509::Certificate.new
    cert.version = 3
    cert.serial = new_serial()
    cert.not_before = h[:not_before]
    cert.not_after = h[:not_after]
    cert.subject = OpenSSL::X509::Name.new([[ "CN", h[:cn] ]])
    cert.public_key = rsa.public_key

    if h[:self_signed]
      seq_true = OpenSSL::ASN1.Sequence([OpenSSL::ASN1::Boolean(true)])
      ex = OpenSSL::X509::Extension.new('basicConstraints', seq_true)
      cert.add_extension(ex)
    end

    if h[:self_signed]
      issuer   = cert.subject
      sign_key = rsa
    else
      issuer   = h[:ca_certificate].subject
      sign_key = h[:ca_key]
    end

    hash = OpenSSL::Digest.new(h[:hash_algorithm].to_s)
    cert.issuer = issuer
    cert.sign(sign_key, hash)
    [ cert, rsa ]
  end
end

class Server
  @@num = 0

  def initialize
    @no = (@@num += 1)
    @dir = File.join(Dir.pwd, "site#{@no}")
    begin
      Dir.mkdir @dir
    rescue Errno::EEXIST
    end
  end

  def mkcert(h={})
    cert, pkey = CertUtils.mkcert(h)
    self.writefile "cert.pem", cert.to_pem
    self.writefile "cert.der", cert.to_der
    self.writefile "pkey.pem", pkey.to_pem
  end

  def writefile rpath, str
    File.open(File.join(@dir, rpath), "w") { |f| f.write(str) }
  end
end

root_cert = root_pkey = nil
if File.exist? "root_cert.pem"
  root_cert = OpenSSL::X509::Certificate.new File.read("root_cert.pem")
  root_pkey = OpenSSL::PKey::RSA.new File.read("root_pkey.pem")
else
  puts "Generating a Certificate for a new root CA..."

  root_cert, root_pkey = CertUtils.mkcert({
    :cn => "100% Trustworthy Certificate Authority",
    :self_signed => true,
    :not_after => Time.now + 86400*365*10   # 10 years
  })
  File.open("root_cert.pem", "w") { |f| f.write(root_cert.to_pem) }
  File.open("root_pkey.pem", "w") { |f| f.write(root_pkey.to_pem) }
end

s = Server.new
s.mkcert({
  :cn => "localhost",
  :ca_certificate => root_cert,
  :ca_key => root_pkey,
  :hash_algorithm => :sha1,
  :not_after => Time.now + 86400 #*360
})
