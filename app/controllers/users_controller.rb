class UsersController < ApplicationController
  before_action :authenticate_user!
  
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
    if User.find(params[:id]) == current_user
      @user = User.find(params[:id])
    else
      redirect_to user_path(current_user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
  end
  
end
