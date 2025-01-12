# frozen_string_literal: true

module Retweets
  module Commands
    class Delete < Command
      def call(tweet:, id:)
        yield delete_retweet(tweet:, id:)

        Success(tweet: Repositories::TweetRepo.new.get(id: tweet.id))
      end

      def delete_retweet(tweet:, id:)
        Success(Repositories::RetweetRepo.new.delete_by_tweet(tweet:, id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
