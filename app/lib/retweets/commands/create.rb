# frozen_string_literal: true

module Retweets
  module Commands
    class Create < Command
      def call(tweet:, user:)
        attrs = {
          tweet:,
          user:
        }

        Success(retweet: create_retweet(attrs:))
      end

      def create_retweet(attrs:)
        Repositories::RetweetRepo.new.create(attrs:)
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
