class MarksController < ApplicationController
  before_action :logged_in_user

  def create
    @book = Book.find_by id: params[:book_id]
    @user_book = @book.marks.build marks_params
    if @user_book.save
      flash[:success] = t "userbook.create.success"
    end
    redirect_to @book
  end

  private
  def marks_params
    params.require(:mark).permit :user_id, :book_id, :mark_type
  end
end
