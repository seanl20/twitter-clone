class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def initialize(tweet:, current_user:)
    @tweet = tweet
    @current_user = current_user
  end

  attr_reader :tweet, :current_user

  delegate :user, :body, :likes_count, to: :tweet
  delegate :display_name, :username, :avatar, to: :user

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime("%b %-d")
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def like_tweet_url
    if tweet_liked_by_user?
      tweet_like_path(tweet, current_user.likes.find_by(tweet:))
    else
      tweet_likes_path(tweet)
    end
  end

  def turbo_data_method
    if tweet_liked_by_user?
      "delete"
    else
      "post"
    end
  end

  def tweet_liked_by_user
    @tweet_liked_by_user ||= tweet.liked_users.include?(current_user)
  end

  alias_method :tweet_liked_by_user?, :tweet_liked_by_user
end
