#/usr/bin/ruby

require 'openssl'
require 'securerandom'
require 'base64'
require 'json'

Yulia = Class.new do
  def enc(dk, plt)
    cipher = OpenSSL::Cipher.new("aes-256-gcm")
    cipher.encrypt

    iv = SecureRandom.random_bytes(128)
    adata = SecureRandom.random_bytes(128)
    cipher.key = dk
    cipher.iv = iv
    cipher.auth_data = adata

    enced = cipher.update(plt) #@TODO test with cipher.final
    enced << cipher.final
    puts Base64.encode64(enced)
  end
end
