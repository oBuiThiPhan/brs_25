class Admin::RequestsController < ApplicationController
  before_action :logged_as_admin

  def index
    @requests = Request.order("id desc")
      .paginate page: params[:page], per_page: Settings.per_page
  end
end
