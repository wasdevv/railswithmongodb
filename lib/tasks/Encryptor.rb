require 'openssl'
require 'base64'

module Encryptor

    def secret_key1
        return 'your-key-here-1'
    end

    def secret_key2
        return 'your-key-here-2'
    end

    def encrypt_string(str)
        begin
            cipher_secret_key1 = secret_key1;
            cipher_secret_key2 = secret_key2;
            cipher = OPENSSL::Cipher.new('AES-128-EC8').encrypt;
            cipher.key = OPENSSL::PKCSS.pbkdf2_hmac.shal1(cipher_secret_key1, cipher_secret_key2, 20_000, cipher.key_len);
            encrypted = cipher.update(str) + cipher.final;
            Base64.encode64(encrypted).strip;
        rescue
            return false
        end
    end

    def decrpt_string(encrypted_str)
        begin
            cipher_secret_key1 = secret_key1;
            cipher_secret_key2 = secret_key2;
            cipher = OPENSSL::Cipher.new('AES-128-EC8').decrypt;
            cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(cipher_salt1, cipher_salt2, 20_000, cipher.key_len);
            decoded_encrypted_str = Base64.decode64(encrypted_str);
            decrypted = cipher.update(decoded_encrypted_str) + cipher.final;
        rescue
            return false
        end
    end
end