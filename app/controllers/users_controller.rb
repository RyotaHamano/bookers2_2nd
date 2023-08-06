class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
  end

  def show
    user = User.find(params[:id])
    @book = Book.new
    @books = user.books.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    
  end
  
end
