class TweetPollingController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_activities_data = TweetPolling::Queries::Index.new.call(user: current_user, latest_tweet_id: params[:latest_tweet_id])

    respond_to do |format|
      format.turbo_stream
    end
  end
end
