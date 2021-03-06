#!/usr/bin/ruby

require "./src/key_derivation.rb"
require "./src/enc.rb"

def choice
  puts "1) Get a key\n2) Encrypt something\n3) Decrypt something\n"
  a = STDIN.gets.chomp
  case a.to_i
  when 1
    if ARGV.empty?
      dk = KeyDerivation.new
      puts "Enter your password:"
      passwd = STDIN.gets.chomp
      puts "Enter the desired key size:"
      key_size = STDIN.gets.chomp
      key = dk.kdf(passwd, key_size)
      puts "Where do you want to get your key?"
      pth = STDIN.gets.chomp
      pth = "key.json" unless pth
      dk.writeIt(key, pth)
    else
      dk = KeyDerivation.new
      key = dk.kdf(ARGV[0], ARGV[1])
      pth = ARGV[2]+"/key.txt"
      dk.writeIt(key, pth)
    end
  when 2
    f = open("./src/key.json", "r")
    js = f.read
    js = JSON.parse(js)
    dk = Base64.decode64(js['k'])
    yulia = Yulia.new
    cipherText = yulia.enc(dk, "es")
    end
end

choice()
exit 0
