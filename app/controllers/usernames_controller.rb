class UsernamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_username_form

  def new
  end

  def update
    result = Users::Commands::Update.new.call(id: current_user.id, params: username_params)

    case result
    in Success(:success)
      flash[:notice] = "Username successfully updated."
      redirect_to dashboard_path
    in Failure(:not_found)
      flash[:alert] = "User not found."
      redirect_to new_username_path
    in Failure(:empty_username)
      flash[:alert] = "Please set a username."
      redirect_to new_username_path
    in Failure(invalid:)
      flash[:alert] = invalid
      redirect_to new_username_path
    end
  end

  private

  def username_params
    params.require(:user).permit(:username, :display_name, :avatar)
  end
end
