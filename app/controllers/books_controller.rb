class BooksController < ApplicationController

  def index
    @books = Book.order("id DESC").paginate page: params[:page],
      per_page: Settings.per_page
  end
end
