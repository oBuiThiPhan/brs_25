class Admin::BooksController < ApplicationController
  before_action :logged_as_admin, only: [:index, :new, :create]
  before_action :get_categories, except: [:index]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "controllers.admin.book.create.flash.success"
      redirect_to admin_books_url
    else
      render :new
    end
  end

  def edit
    @book = Book.find_by id: params[:id]
  end

  def update
    @book = Book.find_by id: params[:id]
    if @book.update_attributes book_params
      redirect_to admin_books_url
    else
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit :category_id, :title, :author,
      :number_of_pages, :publish_date, :image
  end

  def get_categories
    @categories = Category.all
  end
end
