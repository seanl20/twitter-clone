# frozen_string_literal: true

module Notifications
  module Commands
    class Delete < Command
      def call(id:)
        Repositories::NotificationRepo.new.delete(id:)
      end
    end
  end
end
