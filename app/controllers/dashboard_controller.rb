class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_activities_data = Dashboard::Queries::Index.new.call(user: current_user, page: params[:page])
  end
end
