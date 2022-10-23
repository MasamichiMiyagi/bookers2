class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private #←一種の境界線、「ここから下はこのcontrollerの中でしか呼び出せません」という意味があるので、他アクション(create,index,show等)を巻き込まないように一番下に書く。
  #↓以下ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    login_user_id = current_user.id
    if(book.user_id != login_user_id)
      redirect_to books_path
    end
  end
end
