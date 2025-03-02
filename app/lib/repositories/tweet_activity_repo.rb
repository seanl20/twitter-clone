module Repositories
  class TweetActivityRepo
    def create(attrs:)
      TweetActivity.create!(attrs)
    end

    def get_by_user_actor_tweet_verb(user:, actor:, tweet:, verb:)
      TweetActivity.find_by(user:, actor:, tweet:, verb:)
    end

    def delete(id:)
      TweetActivity.find(id).destroy
    end
  end
end
