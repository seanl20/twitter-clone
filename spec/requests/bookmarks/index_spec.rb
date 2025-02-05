require 'rails_helper'

RSpec.describe "GET /bookmarks", type: :request do
  let(:user) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      get bookmarks_path

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    it "succeed" do
      get bookmarks_path

      expect(response).to be_successful
    end
  end
end
