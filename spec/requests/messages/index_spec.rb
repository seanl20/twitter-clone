require 'rails_helper'

RSpec.describe "GET /messages", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user_2) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "return success" do
      get message_threads_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      get message_threads_path(user_id: user_2.id)

      expect(response).to be_successful
    end
  end
end
