module Repositories
  class TweetRepo
    def create(attrs:)
      Tweet.create!(attrs)
    end
  end
end
