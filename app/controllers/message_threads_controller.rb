class MessageThreadsController < ApplicationController
  before_action :authenticate_user!

  def index
    result = MessageThreads::Commands::CreateNew.new.call(user_id: params[:user_id])

    case result
    in Success(new_message_thread_user:)
      @new_message_thread_user = new_message_thread_user
    in Failure(:empty_params)
      redirect_to root_path
    end
  end
end
