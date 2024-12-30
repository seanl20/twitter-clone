require "rails_helper"

RSpec.describe Users::Commands::Update, "#call", :db do
  let(:command) { described_class.new }

  subject(:call) do
    command.call(id:, params:)
  end

  context "user exists" do
    let!(:user) { FactoryBot.create(:user, username: "username01") }
    let!(:user_1) { FactoryBot.create(:user, username: "username02") }

    let(:id) { user.id }

    context "username has been passed" do
      let(:params) do
        {
          username: "user_name"
        }
      end

      it "returns success" do
        expect(call.success).to eq(:success)
      end
    end

    context "empty username has been passed" do
      let(:params) do
        {
          username: ""
        }
      end

      it "returns empty username failure" do
        expect(call.failure).to eq(:empty_username)
      end
    end

    context "existing username has been passed" do
      let(:params) do
        {
          username: "username02"
        }
      end

      it "returns empty username failure" do
        expect(call.failure).to eq({ invalid: "Validation failed: Username has already been taken" })
      end
    end
  end

  context "user does not exists" do
    let(:id) { 1 }

    let(:params) do
      {
        username: "user_name"
      }
    end


    it "returns empty username failure" do
      expect(call.failure).to eq(:not_found)
    end
  end
end
