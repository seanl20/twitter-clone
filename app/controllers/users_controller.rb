class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = Users::Queries::Get.new.call(id: params[:id])
  end
end
