# frozen_string_literal: true

module Tweets
  module Queries
    class Get < Query
      def call(id:, user:)
        tweet = Repositories::TweetRepo.new.get(id:)

        create_view_record(tweet:, user:) unless view_exists?(tweet:, user:)

        TweetPresenter.new(tweet:, current_user: user)
      end

      def create_view_record(tweet:, user:)
        attrs = {
          tweet:,
          user:
        }

        Repositories::ViewRepo.new.create(attrs:)
      end

      def view_exists?(tweet:, user:)
        Repositories::ViewRepo.new.exists?(tweet:, user:)
      end
    end
  end
end
