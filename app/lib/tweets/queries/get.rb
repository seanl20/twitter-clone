# frozen_string_literal: true

module Tweets
  module Queries
    class Get < Query
      def call(id:, user:)
        tweet = Repositories::TweetRepo.new.get(id:)

        ViewTweetJob.perform_later(tweet:, user:)

        TweetPresenter.new(tweet:, current_user: user, tweet_activity: nil)
      end
    end
  end
end
