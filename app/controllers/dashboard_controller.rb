class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_activities_data = Dashboard::Queries::Index.new.call(user: current_user, page: params[:page])

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
