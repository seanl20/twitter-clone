require 'rails_helper'

RSpec.describe "GET /explore", type: :request do
  let(:user) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "return success" do
      get hashtags_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      get hashtags_path

      expect(response).to be_successful
    end
  end
end
