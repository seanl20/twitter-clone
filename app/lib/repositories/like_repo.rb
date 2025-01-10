module Repositories
  class LikeRepo
    def create(attrs:)
      Like.create!(attrs)
    end

    def delete_by_tweet(tweet:, id:)
      Like
        .where(tweet:)
        .find(id)
        .destroy
    end
  end
end
