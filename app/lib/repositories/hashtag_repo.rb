module Repositories
  class HashtagRepo
    def find_or_create(attrs:)
      Hashtag.find_or_create_by(attrs)
    end
  end
end
