# frozen_string_literal: true

module Tweets
  module Queries
    class GetByUser < Query
      def call(user:)
        Repositories::TweetRepo.new.get_by_user(user:).map { |tweet| TweetPresenter.new(tweet:, current_user: user) }
      end
    end
  end
end
