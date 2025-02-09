require 'rails_helper'

RSpec.describe "GET /explore", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:hashtag) { FactoryBot.create(:hashtag) }

  context "when user is not signed in" do
    it "return success" do
      get hashtag_path(hashtag)

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      get hashtag_path(hashtag)

      expect(response).to be_successful
    end
  end
end
