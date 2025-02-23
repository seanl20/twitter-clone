# frozen_string_literal: true

module Notifications
  module Queries
    class GetByUser < Query
      def call(user:)
        Repositories::NotificationRepo.new.get_by_user(user:)
      end
    end
  end
end
