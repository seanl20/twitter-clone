class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages, @user = Messages::Queries::MessageIndex.new.call(message_thread_id: params[:message_thread_id], current_user:, other_user_id: params[:other_user_id])

    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @message = Messages::Commands::Create.new.call(params: message_params, user_id: params[:user_id], current_user:)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to dashboard_path }
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
