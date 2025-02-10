module Repositories
  class HashtagRepo
    def find_or_create(attrs:)
      Hashtag.find_or_create_by(attrs)
    end

    def get_all
      Hashtag.includes(:tweets).all
    end

    def get_all_with_limit(limit: nil)
      Hashtag.includes(:tweets).all.limit(limit)
    end

    def get(id:)
      Hashtag.includes(:tweets).find(id)
    end
  end
end
