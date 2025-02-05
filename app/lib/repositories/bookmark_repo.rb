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

    def get_tweets_by_user(user:)
      Tweet.where(id: Bookmark.where(user:).pluck(:tweet_id))
    end
  end
end
