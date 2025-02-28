require "rails_helper"

RSpec.describe Repositories::RetweetRepo do
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

      it "create retweet" do
        expect { create }.to change { Retweet.count }.by(1)
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

    let!(:retweet) { FactoryBot.create(:retweet, user:, tweet:) }

    context "when retweet exists" do
      let(:id) { retweet.id }

      it "delete tweet" do
        expect { delete_by_tweet }.to change { Retweet.count }.by(-1)
      end
    end

    context "when retweet does not exists" do
      let(:id) { "test" }

      it "returns record invalid" do
        expect { delete_by_tweet }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
