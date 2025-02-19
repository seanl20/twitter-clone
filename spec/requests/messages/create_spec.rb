require 'rails_helper'

RSpec.describe "POST /messages", type: :request do
  let(:user_1) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      post messages_path, params: {
        user_id: user_2.id,
        message: {
          body: "Test Message"
        }
      }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user_1 }

    it "succeed" do
      post messages_path, params: {
        user_id: user_2.id,
        message: {
          body: "Test Message"
        }
      }

      expect(response).to redirect_to(dashboard_path)
    end
  end
end
