# frozen_string_literal: true

module MessageThreads
  module Queries
    class Get < Query
      def call(user_id:, current_user:)
        message_thread_ids = get_message_thread_ids(user: current_user)

        message_threads = Repositories::MessageThreadRepo.new.get_by_ids(ids: message_thread_ids)

        if user_id
          new_message_thread_user = Repositories::UserRepo.new.get(id: user_id)

          return new_message_thread_user, message_threads
        else
          return nil, message_threads
        end
      end

      def get_message_thread_ids(user:)
        Repositories::MessageThreadsUserRepo.new.get_all_by_user(user:).pluck(:message_thread_id)
      end

      def get_common_message_thread_ids(user_message_thread_ids:, my_message_thread_ids:)
        user_message_thread_ids & my_message_thread_ids
      end
    end
  end
end
