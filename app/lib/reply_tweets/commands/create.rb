# frozen_string_literal: true

module ReplyTweets
  module Commands
    class Create < Command
      def call(params:, user:, tweet:)
        ActiveRecord::Base.transaction do
          reply_tweet = create_reply_tweet(params:, user:, tweet:)

          create_replied_tweet_activity(user: tweet.user, actor: user, tweet:) unless reply_tweet.failure

          reply_tweet
        end
      end

      def create_reply_tweet(params:, user:, tweet:)
        attrs = ReplyTweets::Changesets::Create.map(params).merge({ user:, parent_tweet_id: tweet.id })

        Success(reply_tweet: Repositories::TweetRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end

      def create_replied_tweet_activity(user:, actor:, tweet:)
        attrs = {
          user:,
          actor:,
          tweet:,
          verb: Constants::TweetActivity::VERBS[:replied]
        }

        Repositories::TweetActivityRepo.new.create(attrs:)
      end
    end
  end
end
