# frozen_string_literal: true

module Hashtags
  module Queries
    class GetAll < Query
      def call
        Repositories::HashtagRepo.new.get_all
      end
    end
  end
end
