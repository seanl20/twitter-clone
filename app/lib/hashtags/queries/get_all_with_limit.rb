# frozen_string_literal: true

module Hashtags
  module Queries
    class GetAllWithLimit < Query
      def call
        Repositories::HashtagRepo.new.get_all_with_limit(limit: Constants::Hashtag::LIMIT)
      end
    end
  end
end
