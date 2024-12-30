class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Dry::Monads[:result]

  before_action :redirect_to_username_form, if: -> { user_signed_in? && current_user.username.blank? }

  protected

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def redirect_to_username_form
    redirect_to new_username_path
  end
end
