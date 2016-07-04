class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.order("id DESC").paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:warning] = t "views.users.show.nouser"
      redirect_to root_url
    end
    @activities = @user.activities.order("created_at desc").limit(100)
      .paginate page: params[:page], per_page: Settings.per_page
    @reading_books = Book.where(id: Mark.reading.pluck(:book_id))
    @read_books = Book.where(id: Mark.read.pluck(:book_id))
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controllers.flash.common.create_success",
        objects: t("activerecord.model.user")
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = t "controllers.flash.common.update_success",
        objects: t("activerecord.model.user")
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user.is_user? current_user
  end

end
