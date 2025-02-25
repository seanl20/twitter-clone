module Repositories
  class MentionRepo
    def find_or_create(attrs:)
      Mention.find_or_create_by(attrs)
    end
  end
end
