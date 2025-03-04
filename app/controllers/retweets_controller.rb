class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @retweet, @tweet_activity = Retweets::Commands::Create.new.call(tweet:, user: current_user)

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  def destroy
    @tweet, @tweet_activity = Retweets::Commands::Delete.new.call(tweet:, id: params[:id], user: current_user)

    respond_to do |format|
      @tweet = tweet
      format.html { redirect_to dashboard_path }
      format.turbo_stream
    end
  end

  private

  def tweet
    @tweet ||= Repositories::TweetRepo.new.get(id: params[:tweet_id])
  end
end
