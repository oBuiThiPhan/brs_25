class ReviewsController < ApplicationController
  before_action :load_book

  def new
    @review = @book.reviews.build
  end

  def create
    @review = @book.reviews.build review_params
    if @review.save
      redirect_to book_path @book
    else
      render :new
    end
  end

  private

    def review_params
      params.require(:review).permit :rating, :content
    end

    def load_book
      @book = Book.find_by id: params[:book_id]
    end
end
