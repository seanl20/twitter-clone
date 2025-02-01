# frozen_string_literal: true

module Followings
  module Commands
    class Create < Command
      def call(params:, user:)
        attrs = {
          following_user_id: params[:following_user_id],
          user_id: user.id
        }

        yield create_following(attrs:)

        Success(user: Repositories::UserRepo.new.get(id: params[:following_user_id]))
      end

      def create_following(attrs:)
        Success(Repositories::FollowingRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
