#!/usr/bin/ruby

require "./src/key_derivation.rb"

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
      if pth.empty?
        pth = "key.json"
      end
      dk.writeIt(key, pth)
    else
      dk = KeyDerivation.new
      key = dk.kdf(ARGV[0], ARGV[1])
      pth = ARGV[2]+"/key.txt"
      dk.writeIt(key, pth)
    end
  end
end

choice()
exit 0
