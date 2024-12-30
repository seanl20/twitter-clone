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
            username: "test"
          }
        end

        it "updates user" do
          expect { update }.to change { user.reload.username }.from(nil).to("test")
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
end