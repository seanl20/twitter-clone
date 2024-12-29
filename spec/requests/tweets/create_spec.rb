require 'rails_helper'

RSpec.describe "POST /tweets", type: :request do
  let(:user) { FactoryBot.create(:user) }
  context "when user is not signed in" do
    it "redirect to sign in path" do
      post tweets_path, params: {
        tweet: {
          body: "Test Tweet Body"
        }
      }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      post tweets_path, params: {
        tweet: {
          body: "Test Tweet Body"
        }
      }

      expect(response).to redirect_to(dashboard_path)
    end
  end
end
