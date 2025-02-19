class MessageThreadsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user, @message_threads = MessageThreads::Queries::Get.new.call(user_id: params[:user_id], current_user:)
  end
end
