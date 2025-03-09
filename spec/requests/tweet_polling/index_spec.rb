require 'rails_helper'

RSpec.describe "GET /tweet_polling", type: :request do
  let(:user) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "redirect" do
      get tweet_polling_path, headers: { 'Accept': 'text/vnd.turbo-stream.html' }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      get tweet_polling_path, headers: { 'Accept': 'text/vnd.turbo-stream.html' }

      expect(response).to be_successful
    end
  end
end
