class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @user, @tweet_presenters = Users::Queries::GetUserAndTweets.new.call(id: current_user.id)

    render "users/show"
  end

  def update
    @user = current_user
    result = Users::Commands::Update.new.call(id: @user.id, params: user_params)

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
      :profile_url
    )
  end
end
