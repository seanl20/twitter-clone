class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    result = Followings::Commands::Create.new.call(params: following_params, user: current_user)

    case result
    in Success(user:)
      @user = user
      respond_to do |format|
        format.html { redirect_to user_path(user) }
        format.turbo_stream
      end
    in Failure(:invalid)
      redirect_to user_path(following_user)
    end
  end

  def destroy
    result = Followings::Commands::Delete.new.call(id: params[:id])

    case result
    in Success(user:)
      @user = user
      respond_to do |format|
        format.html { redirect_to user_path(user) }
        format.turbo_stream
      end
    end
  end

  private

  def following_user
    @following_user ||= Repositories::UserRepo.new.get(id: params[:following_user_id])
  end

  def following_params
    params.permit(:following_user_id)
  end
end
