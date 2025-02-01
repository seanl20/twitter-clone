# frozen_string_literal: true

module Followings
  module Commands
    class Delete < Command
      def call(id:)
        following = Repositories::FollowingRepo.new.get(id:)

        user = Repositories::UserRepo.new.get(id: following.following_user_id)

        yield delete_following(id:)

        Success(user:)
      end

      def delete_following(id:)
        Success(Repositories::FollowingRepo.new.delete(id:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
