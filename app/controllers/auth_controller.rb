class AuthController < ApplicationController

    def login
        @user = User.find_by(params[:username])

        if @user.nil?
            render json: { message: 'User not found. Please check your username'}, status: :not_found
        elsif @user.authenticate(params[:password])
            token = self.create_token(@user.id.to_s, @user.username, @user.type.to_s)
            @user.update(token: token)
            render json: { message: 'Success Login', user: @user.as_json({ except: [:password_digest] }) }, status: :ok
        else
            render json: { message: 'Wrong Password. Please try again.' }, status: :unprocessable_entity
        end
    end
end