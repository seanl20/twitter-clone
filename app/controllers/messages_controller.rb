class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Messages::Queries::GetByMessageThread.new.call(message_thread_id: params[:message_thread_id])

    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    Messages::Commands::Create.new.call(params: message_params, user_id: params[:user_id], current_user:)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
