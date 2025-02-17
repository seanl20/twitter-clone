module Repositories
  class MessageThreadsUserRepo
    def get_all_by_user(user:)
      MessageThreadsUser.where(user:)
    end

    def get_by_user_and_message_thread(message_thread:, user:)
      
    endMessageThreadsUser.where(message_thread:, user:)
    end
  end
end
