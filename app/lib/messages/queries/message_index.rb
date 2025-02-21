# frozen_string_literal: true

module Messages
  module Queries
    class MessageIndex < Query
      def call(message_thread_id:, current_user:, other_user_id:)
        message_thread = Repositories::MessageThreadRepo.new.get(id: message_thread_id)

        messages = Repositories::MessageRepo.new.get_by_message_thread(message_thread:)

        user = Repositories::UserRepo.new.get(id: other_user_id)

        return messages, user
      end
    end
  end
end
