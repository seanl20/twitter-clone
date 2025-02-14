module Repositories
  class MessageThreadRepo
    def create
      MessageThread.create!
    end

    def get(id:)
      MessageThread.find(id)
    end
  end
end
