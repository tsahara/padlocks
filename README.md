# Browsers

## Google Chrome
- Mac 版はシステムの証明書を信用する

## Safari
- Mac 版はシステムの証明書を信用する(当然)

## Firefox
- Mac 版はシステムの証明書を信用**しない**
- CA 証明書のインポート時に BasicConstraints CA をチェックしている。
  無いとエラーも出さずにインポートが失敗する。
- シリアルをチェックしている。例えばルート認証局の証明書とサーバ証明書のシリアルが一緒だとエラーとする。
  - 「localhost:8801 への接続中にエラーが発生しました。 無効な証明書を受信しました。サーバ管理者またはメール送信者に次の情報を知らせてください: あなたのサーバ証明書は認証局によって発行された他の証明書と同じシリアル番号を持っています。一意なシリアル番号を持つ新しい証明書を取得してください。 (エラーコード: sec_error_reused_issuer_and_serial) 」_

## Microsoft Edge


|            x   | Safari | Chrome | Firefox |
|:---------------|--------|--------|---------|
| SHA1 certificate expires 2015/12 | ![space](https://github.com/tsahara/padlocks/raw/master/safari-no-mark.png)   | ![green](https://github.com/tsahara/padlocks/raw/master/chrome-green.png) | ![green](https://github.com/tsahara/padlocks/raw/master/firefox-green.png) |
| SHA1 certificate expires 2016/12 | ![space](https://github.com/tsahara/padlocks/raw/master/safari-no-mark.png)   | ![gray](https://github.com/tsahara/padlocks/raw/master/chrome-gray.png) | ![green](https://github.com/tsahara/padlocks/raw/master/firefox-green.png) |
| SHA1 certificate expires 2017/1 | ![space](https://github.com/tsahara/padlocks/raw/master/safari-no-mark.png)   | ![red](https://github.com/tsahara/padlocks/raw/master/chrome-red-x.png) | ![green](https://github.com/tsahara/padlocks/raw/master/firefox-green.png) |



## Certificate expires 2017/8

# Reference
- Chrome
  - https://www.globalsign.com/en/blog/google-to-display-warnings-on-sites-that-use-sha-1-certificates/

# TODO
- RSA key &gt;= 768bits, 1024bits, 2048bits
- safe certificate (sha256, rsa2048,...)
- weak cipher (RC4, aes-cbc, ...)
- TLS version (SSLv3, TLS1.0, TLS1.2...)
