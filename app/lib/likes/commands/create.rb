# frozen_string_literal: true

module Likes
  module Commands
    class Create < Command
      def call(tweet:, user:)
        attrs = {
          tweet:,
          user:
        }

        Success(like: create_like(attrs:))
      end

      def create_like(attrs:)
        TweetPresenter.new(Repositories::LikeRepo.new.create(attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
