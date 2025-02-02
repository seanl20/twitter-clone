require 'rails_helper'

RSpec.describe "GET /users/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      get user_path(user_2)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      get user_path(user_2)

      expect(response).to be_successful
    end

    it "redirect to profile path if the user is viewing themselves" do
      get user_path(user)

      expect(response).to redirect_to(profile_path)
    end
  end
end
