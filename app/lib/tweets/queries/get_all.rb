# frozen_string_literal: true

module Tweets
  module Queries
    class GetAll < Query
      def call(user:)
        Repositories::TweetRepo.new.get_all.map { |tweet| TweetPresenter.new(tweet:, current_user: user) }
      end
    end
  end
end
