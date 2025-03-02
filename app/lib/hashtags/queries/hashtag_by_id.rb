# frozen_string_literal: true

module Hashtags
  module Queries
    class HashtagById < Query
      def call(id:, user:)
        hashtag = Repositories::HashtagRepo.new.get(id:)

        tweet_presenters = hashtag.tweets.order(created_at: :desc).map do |tweet|
          TweetPresenter.new(tweet:, current_user: user, tweet_activity: nil)
        end

        return hashtag, tweet_presenters
      end
    end
  end
end
