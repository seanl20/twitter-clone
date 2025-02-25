require "rails_helper"

RSpec.describe Repositories::UserRepo do
  describe "#get" do
    subject(:get) { described_class.new.get(id:) }

    context "user exists" do
      let!(:user) { FactoryBot.create(:user) }

      context "when valid id are passed" do
        let(:id) { user.id }

        it "get tweet" do
          expect(get).to eq(user)
        end
      end

      context "when invalid id are passed" do
        let(:id) { "test" }

        it "returns record not found" do
          expect { get }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "user does not exists" do
      let(:id) { 1 }

      it "returns record not found" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#update" do
    subject(:update) { described_class.new.update(id: user_id, attrs:) }

    context "user exists" do
      let!(:user) { FactoryBot.create(:user, username: nil) }
      let!(:user_id) { user.id }

      context "when valid attrs are passed" do
        let(:attrs) do
          {
            username: "test",
            display_name: "Test Account"
          }
        end

        it "updates user" do
          update
          expect(user.reload.username).to eq("test")
          expect(user.reload.display_name).to eq("Test Account")
        end
      end
    end

    context "user exists" do
      let!(:user_id) { 1 }

      context "when valid attrs are passed" do
        let(:attrs) do
          {
            username: "test"
          }
        end

        it "return record not found" do
          expect { update }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe "#get_by_username" do
    subject(:get_by_username) { described_class.new.get_by_username(username:) }

    context "user exists" do
      let!(:user) { FactoryBot.create(:user, username: "testuser") }

      context "when valid id are passed" do
        let(:username) { "testuser" }

        it "get_by_username tweet" do
          expect(get_by_username).to eq(user)
        end
      end
    end

    context "user does not exists" do
      let(:username) { 1 }

      it "returns record not found" do
        expect(get_by_username).to eq(nil)
      end
    end
  end
end
