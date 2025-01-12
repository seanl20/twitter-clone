require 'rails_helper'

RSpec.describe "DELETE /tweets/:tweet_id/bookmarks/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user:) }

  let!(:bookmark) { FactoryBot.create(:bookmark, user:, tweet:) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      delete tweet_bookmark_path(tweet, bookmark)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      delete tweet_bookmark_path(tweet, bookmark)

      expect(response).to redirect_to(dashboard_path)
    end
  end
end
