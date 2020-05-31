class BooksController < ApplicationController
	before_action :authenticate_user!

	def create
		book = Book.new(book_params)
    	book.user_id = current_user.id
		book.save
		redirect_to book_path(book.id)
	end

	def index
		@books = Book.all
		@book = Book.new
    end

	def show
		@book = Book.find(params[:id])
		@books =Book.new
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		book = Book.find(params[:id])
		Book.update(book_params)
		redirect_to edit_book_path(book.id)
	end

	def destroy
		book = Book.find_by(user_id:current_user.id, title: params[:id], body: params[:id])
		book.destroy
		redirect_to books_path
	end


   private
   def book_params
   	params.require(:book).permit(:title, :body,)
   end
end