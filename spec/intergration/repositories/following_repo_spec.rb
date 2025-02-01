require "rails_helper"

RSpec.describe Repositories::FollowingRepo do
  describe "#get" do
    subject(:get) { described_class.new.get(id:) }

    context "folloing exists" do
      let!(:user_1) { FactoryBot.create(:user) }
      let!(:user_2) { FactoryBot.create(:user) }

      let!(:following) { FactoryBot.create(:following, user: user_1, following_user: user_2) }

      context "when valid id are passed" do
        let(:id) { following.id }

        it "get following" do
          expect(get).to eq(following)
        end
      end

      context "when invalid id are passed" do
        let(:id) { "test" }

        it "returns record not found" do
          expect { get }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "following does not exists" do
      let!(:user_1) { FactoryBot.create(:user) }
      let!(:user_2) { FactoryBot.create(:user) }

      let(:id) { 1 }

      it "returns record not found" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          user: user_1,
          following_user_id: user_2.id
        }
      end

      it "create following" do
        expect { create }.to change { Following.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          following_user_id: user_2.id
        }
      end

      it "returns record invalid" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#delete" do
    subject(:delete) { described_class.new.delete(id:) }

    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }

    let!(:following) { FactoryBot.create(:following, user: user_1, following_user: user_2) }

    context "when like exists" do
      let(:id) { following.id }

      it "delete following" do
        expect { delete }.to change { Following.count }.by(-1)
      end
    end

    context "when like does not exists" do
      let(:id) { "test" }

      it "returns record invalid" do
        expect { delete }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
