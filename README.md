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
| expires 2017/8 | gray   |    -    | -      |



## Certificate expires 2017/8

# Reference
- Chrome
  - https://www.globalsign.com/en/blog/google-to-display-warnings-on-sites-that-use-sha-1-certificates/

# TODO
- make a tool to issue certificates
- sha1 certificate with "Valid After 2015", 2016 and 2017.
- RSA key <= 768bits, 1024bits, 2048bits
       
