require 'Encryptor'

module TokenManager
    include Encryptor

    def self.generate_token(user_id, username, userType)
        extime = (Time.now + 86400 * 2 ).to_i
        token = encrypt_string(user_id) + '.' + encrypted_string(username) + '.' + encrypted_string(userType) + '.' + 
        encrypted_string(extime.to_s)

        return token
    end

    def decrypt_token(token)
        if  token.nil? || token.empty?
            return false
        end

        decry = {};
        d_token = token.split('.').each_with_index do |item, index|
            case index
            when 0
                decry[:id] = decrypt_string(item)
            when 1
                decry[:username] = decrypt_string(item)
            when 2
                decry[:type] = decrypt_string(item)
            when 3
                decry[:token_ex] = decrypt_string(item)
            end
        end
        return decry
    end
end