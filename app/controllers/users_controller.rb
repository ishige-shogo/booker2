class UsersController < ApplicationController

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def show
    @book = Book.new
    user = User.find(params[:id])
    @contents = user.books
    @user = User.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path
      flash[:notice]="You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render template: "books/index"
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice]="You have updated user successfully."
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
