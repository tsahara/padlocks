#!/usr/bin/env ruby

require 'openssl'

rsa = OpenSSL::PKey::RSA.generate 2048

cert = OpenSSL::X509::Certificate.new
cert.version = 3
cert.not_before = Time.now - 86400
cert.not_after = Time.now + 86400
cert.subject = OpenSSL::X509::Name.new([["CN", "Test Root CA"]])
cert.public_key = rsa.public_key

cert.sign(rsa, OpenSSL::Digest::SHA1.new)

File.open("cert-root.pem", "w") { |f| f.write(cert.to_pem) }
