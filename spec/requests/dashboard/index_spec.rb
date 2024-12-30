require 'rails_helper'

RSpec.describe "GET /dashboard", type: :request do
  context "when user is signed in" do
    context "when user have username" do
      let(:user) { FactoryBot.create(:user, username: "username") }

      before { sign_in user }

      it "return success" do
        get dashboard_path

        expect(response).to be_successful
      end
    end

    context "when user does not have username" do
      let(:user) { FactoryBot.create(:user, username: nil) }

      before { sign_in user }

      it "redirect to new username path" do
        get dashboard_path

        expect(response).to redirect_to(new_username_path)
      end
    end
  end

  context "when user is not signed in" do
    it "redirect to sign in path" do
      get dashboard_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
