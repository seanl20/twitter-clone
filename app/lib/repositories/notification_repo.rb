module Repositories
  class NotificationRepo
    def create(attrs:)
      Notification.create!(attrs)
    end

    def get_by_user(user:)
      Notification
        .includes(:user)
        .where(user:)
        .order(created_at: :desc)
    end
  end
end
