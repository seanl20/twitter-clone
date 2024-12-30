require 'rails_helper'

RSpec.describe "PUT /usernames/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }

  context "when user is not signed in" do
    it "redirect to sign in path" do
      put username_path(user), params: {
        user: {
          username: "username"
        }
      }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is signed in" do
    before { sign_in user }

    context "when username params has been passed" do
      it "succeed" do
        put username_path(user), params: {
          user: {
            username: "username"
          }
        }

        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when empty username params has been passed" do
      it "redirect back to new usernames path" do
        put username_path(user), params: {
          user: {
            username: ""
          }
        }

        expect(response).to redirect_to(new_username_path)
      end
    end
  end
end
