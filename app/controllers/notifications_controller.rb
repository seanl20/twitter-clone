class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notifications::Queries::GetByUser.new.call(user: current_user)
  end

  def destroy
    @notification = Notifications::Commands::Delete.new.call(id: params[:id])

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to dashboard_path }
    end
  end
end
