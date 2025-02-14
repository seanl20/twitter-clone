class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    Messages::Commands::Create.new.call(params: message_params, user_id: params[:user_id], current_user:)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
