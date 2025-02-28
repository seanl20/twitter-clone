module Repositories
  class TweetActivityRepo
    def create(attrs:)
      TweetActivity.create!(attrs)
    end
  end
end
