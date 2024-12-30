class UsernamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_username_form

  def new
  end

  def update
    result = Users::Commands::Update.new.call(id: current_user.id, params: username_params)

    case result
    in Success(:success)
      redirect_to dashboard_path
    in Failure(:invalid)
      redirect_to dashboard_path
    in Failure(:not_found)
      redirect_to dashboard_path
    end
  end

  private

  def username_params
    params.require(:user).permit(:username)
  end
end
