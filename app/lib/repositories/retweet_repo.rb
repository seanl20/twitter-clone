module Repositories
  class RetweetRepo
    def create(attrs:)
      Retweet.create!(attrs)
    end

    def delete_by_tweet(tweet:, id:)
      Retweet
        .where(tweet:)
        .find(id)
        .destroy
    end
  end
end
