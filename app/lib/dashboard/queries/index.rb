# frozen_string_literal: true

module Dashboard
  module Queries
    class Index < Query
      def call(user:, page:)
        tweet_activities = user.tweet_activities.order(created_at: :desc).page(1).per(10)

        tweet_activities_data = {
          tweet_activities: tweet_activities.map do |tweet_activity|
            TweetPresenter.new(tweet: tweet_activity.tweet, current_user: user, tweet_activity:)
          end,
          page: tweet_activities.current_page,
          next_page: tweet_activities.next_page,
          last_page: tweet_activities.last_page?,
          total_pages: tweet_activities.total_pages
        }

        tweet_activities_data
      end
    end
  end
end
