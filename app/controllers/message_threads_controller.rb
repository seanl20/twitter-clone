class MessageThreadsController < ApplicationController
  before_action :authenticate_user!

  def index
    @new_message_thread_user, @message_threads = MessageThreads::Queries::Get.new.call(user_id: params[:user_id], current_user:)
  end
end
