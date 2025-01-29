require 'rails_helper'

RSpec.describe "PUT /profile", type: :request do
  let(:user) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      put profile_path, params: {
        user: {
          bio: "New Bio"
        }
      }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      put profile_path, params: {
        user: {
          bio: "New Bio"
        }
      }

      expect(response).to redirect_to(profile_path)
    end
  end
end
