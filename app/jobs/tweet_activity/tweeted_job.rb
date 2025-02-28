class TweetActivity::TweetedJob < ApplicationJob
  queue_as :default

  def perform(actor:, tweet:)
    tweet_activities = actor.followers.map do |follower|
      TweetActivity.new(
        user: follower,
        actor:,
        tweet:,
        verb: Constants::TweetActivity::VERBS[:tweeted]
      )
    end

    TweetActivity.import tweet_activities, on_duplicate_key_ignore: true, batch: 500
  end
end
