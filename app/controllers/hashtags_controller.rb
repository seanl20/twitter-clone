class HashtagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @hashtags = Hashtags::Queries::GetAll.new.call
  end
end
