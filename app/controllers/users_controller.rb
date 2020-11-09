class UsersController < ApplicationController
  def show
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
