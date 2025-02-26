require 'rails_helper'

RSpec.describe "DELETE /notifications/:id", type: :request do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }

  let!(:notification) { FactoryBot.create(:notification, user: user_1, actor: user_2, created_at: 3.minutes.ago) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      delete notification_path(notification)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user_1 }

    it "succeed" do
      delete notification_path(notification)

      expect(response).to redirect_to(dashboard_path)
    end
  end
end
