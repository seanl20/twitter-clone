class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notifications::Queries::GetByUser.new.call(user: current_user)
  end
end
