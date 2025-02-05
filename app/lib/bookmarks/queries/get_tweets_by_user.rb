# frozen_string_literal: true

module Bookmarks
  module Queries
    class GetTweetsByUser < Query
      def call(user:)
        Repositories::BookmarkRepo.new.get_tweets_by_user(user:).map { |tweet| TweetPresenter.new(tweet:, current_user: user) }
      end
    end
  end
end
