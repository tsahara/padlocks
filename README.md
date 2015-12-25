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
- Windows 版はシステムの証明書を信用する(当然)


|            x   | Safari | Chrome | Firefox | Edge |
|:---------------|--------|--------|---------|------|
| SHA1 certificate expires 2015/12 | ![space](https://github.com/tsahara/padlocks/raw/master/safari-no-mark.png)   | ![green](https://github.com/tsahara/padlocks/raw/master/chrome-green.png)     | ![green](https://github.com/tsahara/padlocks/raw/master/firefox-green.png)    | ![gray](https://github.com/tsahara/padlocks/raw/master/edge-gray.png) |
| SHA1 certificate expires 2016/12 | ![space](https://github.com/tsahara/padlocks/raw/master/safari-no-mark.png)   | ![gray](https://github.com/tsahara/padlocks/raw/master/chrome-gray.png)       | ![green](https://github.com/tsahara/padlocks/raw/master/firefox-green.png)    | ![gray](https://github.com/tsahara/padlocks/raw/master/edge-gray.png) |
| SHA1 certificate expires 2017/1  | ![space](https://github.com/tsahara/padlocks/raw/master/safari-no-mark.png)   | ![red](https://github.com/tsahara/padlocks/raw/master/chrome-red-x.png)       | ![green](https://github.com/tsahara/padlocks/raw/master/firefox-green.png)    | ![gray](https://github.com/tsahara/padlocks/raw/master/edge-gray.png) |


# SHA1 Deprecation Policy
- CAB forum
  - ...
- Microsoft Edge
  - will block SHA1 certificate in 2016/6
  - https://blogs.windows.com/msedgedev/2015/11/04/sha-1-deprecation-update/
- Firefox
  - "Untrusted Connection" for the SHA1 certificate issued after 2016/1/1
  - "Untrusted Connection" for the SHA1 certificate with "valid not before"
    2016/1/1
  - "Untrusted Connection" for the SHA1 certificate, after 2017/1/1
  - https://blog.mozilla.org/security/2015/10/20/continuing-to-phase-out-sha-1-certificates/

# Reference
- Chrome
  - https://www.globalsign.com/en/blog/google-to-display-warnings-on-sites-that-use-sha-1-certificates/

# TODO
- RSA key &lt;= 768bits
  - 768bit は
    - Chrome も warning `NET::ERR_CERT_WEAK_KEY`
    - Safari は warning dialog
      "This certificate cannot be used (unsupported key size)"
    - Firefox も The server certificate included a public key that was too weak.
  - 1024bit は影響なし
- weak cipher (RC4, aes-cbc, ...)
  - RC4 は警告なし (chrome/firefox/safari)
  - CBC(AES256) も警告なし (chrome/firefox/safari)
- TLS version (SSLv3, TLS1.0, TLS1.2...)
  - SSLv3 は接続不可 (chrome/firefox/safari)
  - TLS1.0 は影響なし (chrome/firefox/safari)
