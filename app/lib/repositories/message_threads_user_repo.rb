module Repositories
  class MessageThreadsUserRepo
    def get_all_by_user(user:)
      MessageThreadsUser.where(user:)
    end
  end
end
