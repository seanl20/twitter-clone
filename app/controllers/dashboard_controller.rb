class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # @tweets = Tweets::Queries::GetAll.new.call(user: current_user)
    @tweets = Dashboard::Queries::Index.new.call(user: current_user)
  end
end
