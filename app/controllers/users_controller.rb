class UsersController < ApplicationController
    before_action :index, only: [:updateUser, :deleteUser]

    # index
    def index
        @users = User.all
    end

    # new/create
    def addUser
        user = User.new(user_params)
        
        if user.save
            render  json: user, status: :ok
        else                        # Usuário não encontrado PT-BR
            render json: { message: "User not found", error: user.errors }, status: :unprocessable_entity
        end
    end

    # show
    def showUser
        if @user
            render json: @user
        else
            render json: { message: 'Not Found' }, status: :unprocessable_entity # not_found
        end
    end

    # update
    def updateUser
        user = User.find(params[:id])

        if @user && @user.update(user_params)
            render json: @user
        else
            render json: { message: "User not found", error: @user.errors  }, status: :unprocessable_entity
        end
    end

    # delete
    def deleteUser

        if @user
            @user.destroy
            render json: { message: "Successfully deleted the user" }, status: :ok # testarei no not_content
        else
            render json: { message: "Error deleting the user", error: @user.errors }, status: :unprocessable_entity
        end
    end

    private

    # parâmetros
    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
