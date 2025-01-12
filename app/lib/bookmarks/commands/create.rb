# frozen_string_literal: true

module Bookmarks
  module Commands
    class Create < Command
      def call(tweet:, user:)
        attrs = {
          tweet:,
          user:
        }

        Success(bookmark: create_bookmark(attrs:))
      end

      def create_bookmark(attrs:)
        Repositories::BookmarkRepo.new.create(attrs:)
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      end
    end
  end
end
