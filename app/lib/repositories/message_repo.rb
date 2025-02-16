module Repositories
  class MessageRepo
    def create(attrs:)
      Message.create!(attrs)
    end

    def get_by_message_thread(message_thread:)
      Message.where(message_thread:)
    end
  end
end
