# frozen_string_literal: true

module Likes
  module Commands
    class Delete < Command
      def call(tweet:, id:)
        yield delete_like(tweet:, id:)

        Success(tweet: Repositories::TweetRepo.new.get(id: tweet.id))
      end

      def delete_like(tweet:, id:)
        Success(Repositories::LikeRepo.new.delete_by_tweet(tweet:, id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
