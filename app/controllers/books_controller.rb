class BooksController < ApplicationController

before_action :authenticate_user!

before_action :set_book, only: [:update, :edit]


	def create
		@book = Book.new(book_params)
    	@book.user_id = current_user.id
		if @book.save
		   redirect_to book_path(@book.id), notice: "You have creatad book successfully."
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
		@user = User.find(@book.user_id)
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		   redirect_to book_path(@book.id),notice: "You have updated book successfully."
		else
			render :edit 
	    end
	end

	def destroy
		book = Book.find(params[:id])
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

   def set_book
   	     book = Book.find(params[:id])
   	  if book.user_id == current_user.id
      else
         redirect_to books_path
      end
   end
end