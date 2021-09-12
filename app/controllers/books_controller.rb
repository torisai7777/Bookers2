class BooksController < ApplicationController
  before_action :check_book_user, only: [:edit, :update, :destroy]
  
  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @comment = BookComment.new
  end
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      
      redirect_to book_path(@book), notice: "You have created book successfully"
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  
  def edit 
    @book = Book.find(params[:id])
  if @book.user == current_user
        render :edit
  else
        redirect_to books_path
  end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully"
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

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def check_book_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

end
