# frozen_string_literal: true

module Likes
  module Commands
    class Create < Command
      def call(tweet:, user:)
        ActiveRecord::Base.transaction do
          attrs = {
            tweet:,
            user:
          }

          like = create_like(attrs:)

          notification_attrs = {
            user: tweet.user,
            actor: user,
            tweet: tweet,
            verb: Constants::Notification::VERBS[:liked]
          }

          Repositories::NotificationRepo.new.create(attrs: notification_attrs)

          Success(like:)
        end
      end

      def create_like(attrs:)
        Repositories::LikeRepo.new.create(attrs:)
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
