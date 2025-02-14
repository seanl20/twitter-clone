module Repositories
  class MessageRepo
    def create(attrs:)
      Message.create!(attrs)
    end
  end
end
