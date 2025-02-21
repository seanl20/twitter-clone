module Repositories
  class MessageThreadRepo
    def create
      MessageThread.create!
    end

    def get(id:)
      MessageThread.find(id)
    end

    def get_by_ids(ids:)
      MessageThread.includes(:users, :messages).where(id: ids).order(messages: { created_at: :desc })
    end
  end
end
