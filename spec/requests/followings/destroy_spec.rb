require 'rails_helper'

RSpec.describe "DELETE /users/:user_id/followings/:id", type: :request do
  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }

  let(:following) { FactoryBot.create(:following, user: user_1, following_user: user_2) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      delete user_following_path(user_1, following)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user_1 }

    it "succeed" do
      delete user_following_path(user_1, following)

      expect(response).to redirect_to user_path(user_2)
    end
  end
end
