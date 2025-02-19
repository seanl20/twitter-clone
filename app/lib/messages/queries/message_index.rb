# frozen_string_literal: true

module Messages
  module Queries
    class MessageIndex < Query
      def call(message_thread_id:, current_user:)
        message_thread = Repositories::MessageThreadRepo.new.get(id: message_thread_id)

        messages = Repositories::MessageRepo.new.get_by_message_thread(message_thread:)

        user = messages.where.not(user: current_user).first.user

        return messages, user
      end
    end
  end
end
