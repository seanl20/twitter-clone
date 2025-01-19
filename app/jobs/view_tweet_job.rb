class ViewTweetJob < ApplicationJob
  queue_as :default

  def perform(tweet:, user:)
    create_view_record(tweet:, user:) unless view_exists?(tweet:, user:)
  end

  private

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
