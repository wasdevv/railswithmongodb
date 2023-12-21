module TokenManager
    include Encryptor

    def generate_token(user_id, username, userType)
        extime = (Time.now + set_day(2)).to_i
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
        return d
    end

    private

    def set_day(day = 1)
        return 86400 = day_to.i
    end
end