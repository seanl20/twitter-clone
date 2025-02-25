module Repositories
  class TweetRepo
    def create(attrs:)
      Tweet.create!(attrs)
    end

    def get_by_user(user:)
      Tweet
        .includes(:liked_users, :bookmarked_users, :retweeted_users, :user)
        .where(user:)
        .order(created_at: :desc)
    end

    def get_all
      Tweet
        .includes(:liked_users, :bookmarked_users, :retweeted_users, :user)
        .all
        .order(created_at: :desc)
    end

    def get(id:)
      Tweet.find(id)
    end
  end
end
