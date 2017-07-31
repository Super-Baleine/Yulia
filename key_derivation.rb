#!/usr/bin/ruby

require 'openssl'
require 'securerandom'
require 'base64'
require 'json'

def kdf(passwd, length)
  salt = SecureRandom.random_bytes(128)
  iter = 7000
  key = OpenSSL::PKCS5::pbkdf2_hmac_sha1(passwd, salt, iter, length.to_i)
  key = Base64.encode64(key)
  salt = Base64.encode64(salt)
  js = {:k=>key,:s=>salt}.to_json
  return js
end

def writeIt(z)
  f = open("key.txt", "w")
  f.write(z)
  f.close
end

r = kdf(ARGV[0], ARGV[1])
writeIt(r)

exit 0
