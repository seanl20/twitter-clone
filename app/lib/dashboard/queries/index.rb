# frozen_string_literal: true

module Dashboard
  module Queries
    class Index < Query
      def call(user:)
        following_users = user.following_users

        Repositories::TweetRepo.new.get_by_user(user: following_users).map { |tweet| TweetPresenter.new(tweet:, current_user: user) }
      end
    end
  end
end
