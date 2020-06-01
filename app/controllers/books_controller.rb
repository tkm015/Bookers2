class BooksController < ApplicationController
	before_action :authenticate_user!

	def create
		@book = Book.new(book_params)
    	@book.user_id = current_user.id
		if @book.save
		   redirect_to book_path(@book.id)
		else
			@books = Book.all
			render :index
		end
	end

	def index
		@books = Book.all
		@book = Book.new
    end

	def show
		@book = Book.find(params[:id])
		@books =Book.new
		@user = User.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		book = Book.find(params[:id])
		book.update(book_params)
		redirect_to edit_book_path(book.id)
	end

	def destroy
		book = Book.find_by(user_id:current_user.id, title: params[:id], body: params[:id])
		book.destroy
		redirect_to books_path
	end


   private
   def user_params
    params.require(:user).permit(:name, :profile_image, :introduction,)
    end

   def book_params
   	params.require(:book).permit(:title, :body,)
   end
end