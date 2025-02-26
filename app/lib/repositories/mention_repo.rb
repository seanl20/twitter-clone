module Repositories
  class MentionRepo
    def create(attrs:)
      Mention.create!(attrs)
    end
  end
end
