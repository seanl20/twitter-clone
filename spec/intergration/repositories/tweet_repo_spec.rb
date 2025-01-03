require "rails_helper"

RSpec.describe Repositories::TweetRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user) { FactoryBot.create(:user) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          body: "test",
          user:
        }
      end

      it "create tweet" do
        expect { create }.to change { Tweet.count }.by(1)
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

  describe "#create" do
    subject(:get_by_user) { described_class.new.get_by_user(user:) }

    context "when user exists" do
      let!(:user) { FactoryBot.create(:user) }

      context "user have tweets" do
        let!(:tweet_1) { FactoryBot.create(:tweet, user:, created_at: 3.minutes.ago) }
        let!(:tweet_2) { FactoryBot.create(:tweet, user:, created_at: 2.minutes.ago) }
        let!(:tweet_3) { FactoryBot.create(:tweet, user:, created_at: 1.minutes.ago) }

        it "create tweet" do
          expect(get_by_user).to match_ordered_elements(tweet_3, tweet_2, tweet_1)
        end
      end

      context "user does not have tweets" do
        it "returns record invalid" do
          expect(get_by_user).to be_empty
        end
      end
    end

    context "when user does not exists" do
      context "user does not have tweets" do
        let!(:user) { "Test" }

        it "returns record invalid" do
          expect(get_by_user).to be_empty
        end
      end
    end
  end
end
