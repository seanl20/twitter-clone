class ReplyTweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    result = ReplyTweets::Commands::Create.new.call(params: reply_tweet_params, user: current_user, tweet:)

    case result
    in Success(reply_tweet:)
      @tweet = reply_tweet
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    in Failure(:invalid)
      redirect_to dashboard_path
    end
  end

  private

  def tweet
    @tweet ||= Repositories::TweetRepo.new.get(id: params[:tweet_id])
  end

  def reply_tweet_params
    params.require(:tweet).permit(:body)
  end
end
