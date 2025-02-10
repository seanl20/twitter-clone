class HashtagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @hashtags = Hashtags::Queries::GetAll.new.call
  end

  def show
    @hashtag, @tweet_presenters = Hashtags::Queries::HashtagById.new.call(id: params[:id], user: current_user)
  end
end
