class TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    result = Tweets::Commands::Create.new.call(params: tweet_params, user: current_user)

    case result
    in Success(:success)
      redirect_to dashboard_path
    in Failure(:invalid)
      redirect_to dashboard_path
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
