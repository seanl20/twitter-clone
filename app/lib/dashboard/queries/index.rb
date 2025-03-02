# frozen_string_literal: true

module Dashboard
  module Queries
    class Index < Query
      def call(user:)
        tweet_activities = user.tweet_activities.order(created_at: :desc).map do |tweet_activity|
          TweetPresenter.new(tweet: tweet_activity.tweet, current_user: user)
        end

        tweet_activities
      end
    end
  end
end
