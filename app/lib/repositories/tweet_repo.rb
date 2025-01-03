module Repositories
  class TweetRepo
    def create(attrs:)
      Tweet.create!(attrs)
    end

    def get_by_user(user:)
      Tweet
        .includes(:user)
        .where(user:)
        .order(created_at: :desc)
    end
  end
end
