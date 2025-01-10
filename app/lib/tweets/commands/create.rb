# frozen_string_literal: true

module Tweets
  module Commands
    class Create < Command
      def call(params:, user:)
        attrs = Tweets::Changesets::Create.map(params).merge({ user: })

        Success(tweet: create_tweet(attrs:, user:))
      end

      def create_tweet(attrs:, user:)
        TweetPresenter.new(tweet: Repositories::TweetRepo.new.create(attrs:), current_user: user)
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
