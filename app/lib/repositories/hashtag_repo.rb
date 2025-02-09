module Repositories
  class HashtagRepo
    def find_or_create(attrs:)
      Hashtag.find_or_create_by(attrs)
    end

    def get_all
      Hashtag.all
    end
  end
end
