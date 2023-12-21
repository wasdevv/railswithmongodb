class AuthController < ApplicationController

    def login
        @user = User.find_by!(params[:username])

        if !user
            render json: { message: 'Username or password incorrect, try again!'}, status: :unprocessable_entity
            return true
        end

        if user.authenticate(params[:password])
            render json: { message: 'Success Login', user: user }, status: :ok
        else
            render json: { message: 'Wrong Password or Email, try again!'}, status: :unprocessable_entity
        end
    end
end