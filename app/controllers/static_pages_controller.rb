class StaticPagesController < ApplicationController
  def home
    @activities = Activity.order("created_at desc").limit(20)
  end

  def help
  end

  def contact
  end
end
