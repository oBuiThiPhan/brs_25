class LikeActivitiesController < ApplicationController
  before_action :logged_in_user, :load_activity

  def create
    @like = current_user.like_activities.create like_activities_params
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def destroy
    @like = LikeActivity.find_by id: params[:id]
    @like.destroy if @like
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  private
  def like_activities_params
    params.require(:like_activity).permit :activity_id
  end

  def load_activity
    @activity = Activity.find_by id: params[:like_activity][:activity_id]
  end
end
