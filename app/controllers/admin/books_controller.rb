class Admin::BooksController < ApplicationController
  before_action :logged_as_admin, only: [:index, :new, :create]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "controllers.admin.books.create.flash.success"
      redirect_to admin_books_url
    else
      @categories = Category.all
      render :new
    end
  end

  private
  def book_params
    params.require(:book).permit :category, :title, :author,
      :number_of_pages, :publish_date, :image
  end

end
