# frozen_string_literal: true

module Bookmarks
  module Commands
    class Delete < Command
      def call(tweet:, id:)
        yield delete_bookmark(tweet:, id:)

        Success(tweet: Repositories::TweetRepo.new.get(id: tweet.id))
      end

      def delete_bookmark(tweet:, id:)
        Success(Repositories::BookmarkRepo.new.delete_by_tweet(tweet:, id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
