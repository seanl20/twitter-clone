require 'rails_helper'

RSpec.describe "POST /users/:user_id/followings", type: :request do
  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      post user_followings_path(user_1), params: {
        followings: {
          following_user_id: user_2.id
        }
      }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user_1 }

    it "succeed" do
      post user_followings_path(user_1), params: {
        following_user_id: user_2.id
      }

      expect(response).to redirect_to user_path(user_2)
    end
  end
end
