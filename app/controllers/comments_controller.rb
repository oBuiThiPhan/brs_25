class CommentsController < ApplicationController
  before_action :load_book
  before_action :load_review
  before_action :load_comment

  def new
    @comment = @review.comments.build
  end

  def create
    @comment = @review.comments.build comment_params
    if @comment.save
      redirect_to @book
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update comment_params
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @book
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
  end

  def load_review
    @review = Review.find_by id: params[:review_id]
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end

end
