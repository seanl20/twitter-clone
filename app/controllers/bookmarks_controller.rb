class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarked_tweets = Bookmarks::Queries::GetTweetsByUser.new.call(user: current_user)
  end

  def create
    result = Bookmarks::Commands::Create.new.call(tweet:, user: current_user)

    case result
    in Success(bookmark:)
      @bookmark  = bookmark
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    in Failure(:invalid)
      redirect_to dashboard_path
    end
  end

  def destroy
    result = Bookmarks::Commands::Delete.new.call(tweet:, id: params[:id])

    case result
    in Success(tweet:)
      respond_to do |format|
        @tweet = tweet
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
end
