# frozen_string_literal: true

module Likes
  module Commands
    class Delete < Command
      def call(tweet:, id:, user:)
        yield delete_like(tweet:, id:)

        Success(tweet: Repositories::TweetRepo.new.get(id: tweet.id))
      end

      def delete_like(tweet:, id:)
        Success(Repositories::LikeRepo.new.delete_by_tweet(tweet:, id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end

      def delete_tweet_activity(user:, tweet:)
        tweet_activity = Repositories::TweetActivityRepo.new.get_by_user_actor_tweet_verb(user: tweet.user, actor: current_user, tweet:, verb: Constants::TweetActivity::VERBS[:liked])

        Repositories::TweetActivityRepo.new.delete(id: tweet_activity.id)
      end
    end
  end
end
