require "rails_helper"

RSpec.describe Repositories::LikeRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user:) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          tweet:,
          user:
        }
      end

      it "create tweet" do
        expect { create }.to change { Like.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          user:
        }
      end

      it "returns record invalid" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#delete_by_tweet" do
    subject(:delete_by_tweet) { described_class.new.delete_by_tweet(tweet:, id:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user:) }

    let!(:like) { FactoryBot.create(:like, user:, tweet:) }

    context "when like exists" do
      let(:id) { like.id }

      it "delete tweet" do
        expect { delete_by_tweet }.to change { Like.count }.by(-1)
      end
    end

    context "when like does not exists" do
      let(:id) { "test" }

      it "returns record invalid" do
        expect { delete_by_tweet }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
