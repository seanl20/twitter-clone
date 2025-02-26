module Repositories
  class NotificationRepo
    def create(attrs:)
      Notification.create!(attrs)
    end

    def get_by_user(user:)
      Notification
        .includes(:user, :tweet)
        .where(user:)
        .order(created_at: :desc)
    end

    def delete(id:)
      Notification
        .find(id)
        .destroy
    end
  end
end
