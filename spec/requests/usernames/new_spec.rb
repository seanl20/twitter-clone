require 'rails_helper'

RSpec.describe "GET /usernames/new", type: :request do
  context "when user is not signed in" do
    it "redirect to sign in path" do
      get new_username_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    let(:user) { FactoryBot.create(:user, username: nil) }

    before { sign_in user }

    it "return success" do
      get new_username_path

      expect(response).to be_successful
    end
  end
end
