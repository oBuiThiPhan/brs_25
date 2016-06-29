class ReviewsController < ApplicationController
  before_action :load_book
  before_action :load_review, only: [:edit, :update, :destroy]

  def new
    @review = @book.reviews.build
  end

  def create
    @review = @book.reviews.build review_params
    if @review.save
      redirect_to @book
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update review_params
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to @book
  end

  private
  def review_params
    params.require(:review).permit :rating, :content
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
  end

  def load_review
    @review = Review.find_by id: params[:id]
  end

end
