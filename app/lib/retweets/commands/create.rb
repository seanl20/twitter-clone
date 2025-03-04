# frozen_string_literal: true

module Retweets
  module Commands
    class Create < Command
      def call(tweet:, user:)
        ActiveRecord::Base.transaction do
          retweet = create_retweet(tweet:, user:)

          tweet_activity = create_retweet_tweet_activity(user:, actor: user, tweet:)

          return retweet, tweet_activity
        end
      end

      def create_retweet(tweet:, user:)
        attrs = {
          tweet:,
          user:
        }

        Repositories::RetweetRepo.new.create(attrs:)
      end

      def create_retweet_tweet_activity(user:, actor:, tweet:)
        attrs = {
          user:,
          actor:,
          tweet:,
          verb: Constants::TweetActivity::VERBS[:retweeted]
        }

        Repositories::TweetActivityRepo.new.create(attrs:)
      end
    end
  end
end
