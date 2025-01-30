class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    result = Users::Commands::Update.new.call(id: current_user.id, params: user_params)

    case result
    in Success(:success)
      respond_to do |format|
        format.html { redirect_to profile_path }
        format.turbo_stream
      end
    in Failure(:empty_username)
      respond_to do |format|
        format.html { redirect_to profile_path }
        format.turbo_stream
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :display_name,
      :email,
      :password,
      :location,
      :bio,
      :url
    )
  end
end
