# frozen_string_literal: true

module Tweets
  module Commands
    class Create < Command
      def call(params:, user:)
        attrs = Tweets::Changesets::Create.map(params).merge({ user: })

        yield create_tweet(attrs:)

        Success(tweet: user.tweets.last)
      end

      def create_tweet(attrs:)
        Success(Repositories::TweetRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
