# frozen_string_literal: true

module ReplyTweets
  module Queries
    class GetAll < Query
      def call(id:, user:)
        tweet = Repositories::TweetRepo.new.get(id:)

        reply_tweets_in_presenter = tweet.reply_tweets.includes(
          :liked_users, :bookmarked_users, :retweeted_users, :user
        ).order(created_at: :desc).map do |reply_tweet|
          TweetPresenter.new(tweet: reply_tweet, current_user: user)
        end

        reply_tweets_in_presenter
      end
    end
  end
end
