class Admin::RequestsController < ApplicationController
  before_action :logged_as_admin
  before_action :load_request, only: [:destroy]

  def index
    @requests = Request.order("created_at desc")
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def destroy
    if @request && @request.destroy
      flash[:success] = t "controllers.flash.common.destroy_success",
        objects: t("activerecord.model.request")
    else
      flash[:danger] = t "controllers.flash.common.destroy_error",
        objects: t("activerecord.model.request")
    end
    redirect_to admin_requests_url
  end

  private
  def load_request
    @request = Request.find_by id: params[:id]
  end
end
