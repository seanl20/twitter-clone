# frozen_string_literal: true

module ReplyTweets
  module Commands
    class Create < Command
      def call(params:, user:, tweet:)
        attrs = ReplyTweets::Changesets::Create.map(params).merge({ user:, parent_tweet_id: tweet.id })

        Success(reply_tweet: create_reply_tweet(attrs:))
      end

      def create_reply_tweet(attrs:)
        Repositories::TweetRepo.new.create(attrs:)
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
