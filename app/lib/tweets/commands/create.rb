# frozen_string_literal: true

module Tweets
  module Commands
    class Create < Command
      def call(params:, user:)
        attrs = Tweets::Changesets::Create.map(params).merge({ user: })

        tweet = Repositories::TweetRepo.new.create(attrs:)

        TweetActivity::TweetedJob.perform_later(actor: user, tweet:)

        Success(tweet: TweetPresenter.new(tweet:, current_user: user, tweet_activity: nil))
      end
    end
  end
end
