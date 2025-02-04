# frozen_string_literal: true

module Users
  module Queries
    class GetUserAndTweets < Query
      def call(id:)
        user = Repositories::UserRepo.new.get(id:)
        tweets = Repositories::TweetRepo.new.get_by_user(user:)

        tweet_presenters = tweets.map do |tweet|
          TweetPresenter.new(tweet:, current_user: user)
        end
        return user, tweet_presenters
      end
    end
  end
end
