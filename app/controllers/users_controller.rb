class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.all
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
  
  def follows
    @user = User.find(params[:id])
    @users = @user.follow_user
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followed_user
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice:'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
end
