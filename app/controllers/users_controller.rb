class UsersController < ApplicationController

before_action :authenticate_user!

before_action :set_user, only: [:update, :edit]

	def index
		@book = Book.new
		@users = User.all
	end

	def show
		@book = Book.new
		@books= Book.where(user_id: params[:id])
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end


	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   redirect_to user_path(@user.id), notice: "You have updated user successfully."
		else
		   render :edit
		end
	end

	private


    def user_params
    params.require(:user).permit(:name, :profile_image, :introduction,)
    end

    def set_user
   	     user = User.find(params[:id])
   	  if user.id == current_user.id
      else
         redirect_to user_path(current_user)
      end
    end

end

