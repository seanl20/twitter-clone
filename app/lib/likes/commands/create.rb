# frozen_string_literal: true

module Likes
  module Commands
    class Create < Command
      def call(tweet:, user:)
        ActiveRecord::Base.transaction do
          like = create_like(tweet:, user:)

          create_notification(user: tweet.user, actor: user, tweet:)

          create_like_tweet_activity(user: tweet.user, actor: user, tweet:)

          Success(like:)
        end
      end

      def create_like(tweet:, user:)
        attrs = {
          tweet:,
          user:
        }

        Repositories::LikeRepo.new.create(attrs:)
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end

      def create_notification(user:, actor:, tweet:)
        notification_attrs = {
          user:,
          actor:,
          tweet:,
          verb: Constants::Notification::VERBS[:liked]
        }

        Repositories::NotificationRepo.new.create(attrs: notification_attrs)
      end

      def create_like_tweet_activity(user:, actor:, tweet:)
        attrs = {
          user:,
          actor:,
          tweet:,
          verb: Constants::TweetActivity::VERBS[:liked]
        }

        Repositories::TweetActivityRepo.new.create(attrs:)
      end
    end
  end
end
