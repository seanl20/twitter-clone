class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def initialize(tweet:, current_user:, tweet_activity:)
    @tweet = tweet
    @current_user = current_user
    @tweet_activity = tweet_activity
  end

  attr_reader :tweet, :current_user, :tweet_activity

  delegate :user, :likes_count, :retweets_count, :views_count, :reply_tweets_count, to: :tweet
  delegate :display_name, :username, to: :user

  def tweet_activity_html
    case tweet_activity&.verb
    when Constants::TweetActivity::VERBS[:liked]
      "<p class=\"fw-bold text-muted mb-0\" style=\"margin-left: 5rem; font-size: 13px\">#{tweet_activity.actor.display_name} liked</p>"
    when Constants::TweetActivity::VERBS[:replied]
      "<p class=\"fw-bold text-muted mb-0\" style=\"margin-left: 5rem; font-size: 13px\">#{tweet_activity.actor.display_name} replied to</p>"
    when Constants::TweetActivity::VERBS[:retweeted]
      "<p class=\"fw-bold text-muted mb-0\" style=\"margin-left: 5rem; font-size: 13px\">#{tweet_activity.actor.display_name} retweeted</p>"
    else
      ""
    end
  end

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime("%b %-d")
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def body_html(p_classes: "")
    texts = tweet.body.split(" ").map do |word|
      if word.include?("#") || word.include?("@")
        "<a class=\"twitter-link\">#{word}</a>"
      else
        word
      end
    end

    "<p class=\"#{p_classes}\">#{texts.join(" ")}</p>"
  end

  def avatar
    return user.avatar if user.avatar.present?

    ActionController::Base.helpers.asset_path("user.png")
  end

  def like_tweet_url(source: "dashboard/index")
    if tweet_liked_by_user?
      tweet_like_path(tweet, current_user.likes.find_by(tweet:), source:)
    else
      tweet_likes_path(tweet, source:)
    end
  end

  def bookmark_tweet_url(source: "dashboard/index")
    if tweet_bookmarked_by_user?
      tweet_bookmark_path(tweet, current_user.bookmarks.find_by(tweet:), source:)
    else
      tweet_bookmarks_path(tweet, source:)
    end
  end

  def retweet_tweet_url(source: "dashboard/index")
    if tweet_retweeted_by_user?
      tweet_retweet_path(tweet, current_user.retweets.find_by(tweet:), source:)
    else
      tweet_retweets_path(tweet, source:)
    end
  end

  def turbo_like_data_method
    if tweet_liked_by_user?
      "delete"
    else
      "post"
    end
  end

  def turbo_bookmark_data_method
    if tweet_bookmarked_by_user?
      "delete"
    else
      "post"
    end
  end

  def turbo_retweet_data_method
    if tweet_retweeted_by_user?
      "delete"
    else
      "post"
    end
  end

  def heart_icon
    if tweet_liked_by_user?
      "tweets/heart/filled"
    else
      "tweets/heart/unfilled"
    end
  end

  def bookmark_icon
    if tweet_bookmarked_by_user?
      "tweets/bookmark/filled"
    else
      "tweets/bookmark/unfilled"
    end
  end

  def retweet_colour_class
    if tweet_retweeted_by_user?
      "text-success"
    else
      "text-black"
    end
  end

  def bookmark_text
    if tweet_bookmarked_by_user?
      "Bookmarked"
    else
      "Bookmark"
    end
  end

  private

  def tweet_liked_by_user
    @tweet_liked_by_user ||= tweet.liked_users.include?(current_user)
  end

  alias_method :tweet_liked_by_user?, :tweet_liked_by_user

  def tweet_bookmarked_by_user
    @tweet_bookmarked_by_user ||= tweet.bookmarked_users.include?(current_user)
  end

  alias_method :tweet_bookmarked_by_user?, :tweet_bookmarked_by_user

  def tweet_retweeted_by_user
    @tweet_retweeted_by_user ||= tweet.retweeted_users.include?(current_user)
  end

  alias_method :tweet_retweeted_by_user?, :tweet_retweeted_by_user
end
