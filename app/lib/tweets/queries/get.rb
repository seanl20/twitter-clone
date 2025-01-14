# frozen_string_literal: true

module Tweets
  module Queries
    class Get < Query
      def call(id:)
        Repositories::TweetRepo.new.get(id:)
      end
    end
  end
end
