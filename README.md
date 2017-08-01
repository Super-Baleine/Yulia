Some scripts I write for fun.

# Usage

## main.rb

```
chmod +x main.rb;
./main.rb;
```

## key_derivation.rb

### CLI

```
chmod +X key_derivation.rb;
./key_derivation.rb password key_size
```

### Code

```ruby
require "./key_derivation.rb"
dk = KeyDerivation.new
key = dk.kdf("password", 256)
```

The key will be base64-encoded and stored in a JSON with the salt, the iteration number, and the key size.
