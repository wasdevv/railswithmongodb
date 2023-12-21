require 'openssl'
require 'base64'

module Encryptor

    KEY = 'your-key-here'
    ITERATIONS = 20_000
    KEY_LEN = 128
    CIPHER = 'AES-128-ECB'

    def self.encrypt_string(str)
        cipher = OpenSSL::Cipher.new(CIPHER).encrypt
        cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(KEY, KEY, ITERATIONS, KEY_LEN)
        encrypted = cipher.update(str) + cipher.final
        Base64.encode64(encrypted).strip
    end

    def decrpt_string(encrypted_str)
        unless encrypted_str.is_a?(String)
            raise ArgumentError, 'Encrypted string must be a String'
        end

        begin
            # Decode the base64 encrypted string
            decoded_encrypted_str = Base64.decode64(encrypted_str)
    
            # Create a new cipher object for decryption
            cipher = OpenSSL::Cipher.new(CIPHER).decrypt
    
            # Derive the key and IV from the secret keys and salts
            cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(KEY, KEY, ITERATIONS, KEY_LEN)
    
            # Decrypt the encrypted string
            decrypted = cipher.update(decoded_encrypted_str) + cipher.final
        rescue ArgumentError => e
            # Handle argument errors
            puts "Error: #{e.message}"
            return false
        rescue OpenSSL::Cipher::CipherError => e
            # Handle decryption errors
            puts "Error: #{e.message}"
            return false
        end
        decrypted
    end
end