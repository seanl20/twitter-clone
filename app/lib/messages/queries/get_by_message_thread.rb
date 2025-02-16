# frozen_string_literal: true

module Messages
  module Queries
    class GetByMessageThread < Query
      def call(message_thread_id:)
        message_thread = Repositories::MessageThreadRepo.new.get(id: message_thread_id)

        Repositories::MessageRepo.new.get_by_message_thread(message_thread:)
      end
    end
  end
end
