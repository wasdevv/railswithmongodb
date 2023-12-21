class ApplicationController < ActionController::Base
    include TokenManager

    def token_create(user_id, username, user_type)
        return generate_token(user_id, username, user_type)
    end

    def auth_check(user_type = 1, return_user = false )
        user_token = decrypt_token(request.headers['token'])
        if !user_token # || user_token[:expired] == true
            account = User.find(user_token[:id])
            if account
                if user_token(:token_ex) < TIme.now.to_i
                    render json: { message:'Token has expired' }, status: :unauthorized
                else
                    if return_user
                        render json: { message: 'Token Authorized', user: account }, status: :ok
                    else
                        return true;
                    end
                end
            else
                render json: { message:'Invalid or non-existent account.'}, status: :unauthorized
            end
        else
            render json: { message:'Token unacceptable' }, status: :unauthorized
        end
    end


end
