class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweets::Queries::GetByUser.new.call(user: current_user)
  end
end
