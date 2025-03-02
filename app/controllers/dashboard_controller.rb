class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_activities = Dashboard::Queries::Index.new.call(user: current_user)
  end
end
