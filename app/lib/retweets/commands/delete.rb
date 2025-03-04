# frozen_string_literal: true

module Retweets
  module Commands
    class Delete < Command
      def call(tweet:, id:, user:)
        ActiveRecord::Base.transaction do
          delete_retweet(tweet:, id:)

          tweet_activity = delete_retweet_tweet_activity(user:, actor: user, tweet:)

          tweet = Repositories::TweetRepo.new.get(id: tweet.id)

          return tweet, tweet_activity
        end
      end

      def delete_retweet(tweet:, id:)
        Repositories::RetweetRepo.new.delete_by_tweet(tweet:, id:)
      end

      def delete_retweet_tweet_activity(user:, actor:, tweet:)
        tweet_activity = Repositories::TweetActivityRepo.new.get_by_user_actor_tweet_verb(user:, actor:, tweet:, verb: Constants::TweetActivity::VERBS[:retweeted])

        Repositories::TweetActivityRepo.new.delete(id: tweet_activity.id)
      end
    end
  end
end
