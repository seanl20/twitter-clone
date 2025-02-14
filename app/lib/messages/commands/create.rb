# frozen_string_literal: true

module Messages
  module Commands
    class Create < Command
      def call(params:, user_id:, current_user:)
        user = Repositories::UserRepo.new.get(id: user_id)

        user_message_thread_ids = get_message_thread_ids(user:)
        my_message_thread_ids = get_message_thread_ids(user: current_user)

        common_message_thread_ids = get_common_message_thread_ids(user_message_thread_ids:, my_message_thread_ids:)

        ActiveRecord::Base.transaction do
          message_thread = create_or_get_message_thread(common_message_thread_ids:, user:, current_user:)

          create_message(params:, message_thread:, current_user:)
        end
      end

      def get_message_thread_ids(user:)
        Repositories::MessageThreadsUserRepo.new.get_all_by_user(user:).pluck(:message_thread_id)
      end

      def get_common_message_thread_ids(user_message_thread_ids:, my_message_thread_ids:)
        user_message_thread_ids & my_message_thread_ids
      end

      def create_or_get_message_thread(common_message_thread_ids:, user:, current_user:)
        if common_message_thread_ids.empty?
          message_thread = Repositories::MessageThreadRepo.new.create
          user.message_threads << message_thread
          current_user.message_threads << message_thread
        else
          message_thread = Repositories::MessageThreadRepo.new.get(id: common_message_thread_ids.first)
        end
        message_thread
      end

      def create_message(params:, message_thread:, current_user:)
        attrs = Messages::Changesets::Create.map(params).merge({ user: current_user, message_thread: })

        Repositories::MessageRepo.new.create(attrs:)
      end
    end
  end
end
