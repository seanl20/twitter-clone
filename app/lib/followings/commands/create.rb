# frozen_string_literal: true

module Followings
  module Commands
    class Create < Command
      def call(params:, user:)
        attrs = {
          following_user_id: params[:following_user_id],
          user_id: user.id
        }

        following_user = Repositories::UserRepo.new.get(id: params[:following_user_id])

        ActiveRecord::Base.transaction do
          yield create_following(attrs:)

          notification_attrs = {
            user_id: params[:following_user_id],
            actor_id: user.id,
            verb: Constants::Notification::VERBS[:follow]
          }

          Repositories::NotificationRepo.new.create(attrs: notification_attrs)
        end

        Success(user: following_user)
      end

      def create_following(attrs:)
        Success(Repositories::FollowingRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
