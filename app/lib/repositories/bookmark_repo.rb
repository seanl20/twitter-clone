module Repositories
  class BookmarkRepo
    def create(attrs:)
      Bookmark.create!(attrs)
    end

    def delete_by_tweet(tweet:, id:)
      Bookmark
        .where(tweet:)
        .find(id)
        .destroy
    end
  end
end
