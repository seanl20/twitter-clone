class TweetsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tweet = Tweets::Queries::Get.new.call(id: params[:id])
    @tweet_presenter = TweetPresenter.new(tweet: @tweet, current_user:)
  end

  def create
    result = Tweets::Commands::Create.new.call(params: tweet_params, user: current_user)

    case result
    in Success(tweet:)
      @tweet = tweet
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    in Failure(:invalid)
      redirect_to dashboard_path
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
