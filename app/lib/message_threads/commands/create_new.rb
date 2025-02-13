# frozen_string_literal: true

module MessageThreads
  module Commands
    class CreateNew < Command
      def call(user_id:)
        if user_id
          new_message_thread_user = Repositories::UserRepo.new.get(id: user_id)
          Success(new_message_thread_user:)
        else
          Failure(:empty_params)
        end
      end
    end
  end
end
