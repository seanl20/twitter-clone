require "rails_helper"

RSpec.describe Repositories::TweetActivityRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          user: user_1,
          actor: user_2,
          tweet:,
          verb: Constants::TweetActivity::VERBS[:tweeted]
        }
      end

      it "create notification" do
        expect { create }.to change { TweetActivity.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          user: user_1
        }
      end

      it "returns record invalid" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#get_by_user_actor_tweet_verb" do
    subject(:get_by_user_actor_tweet_verb) { described_class.new.get_by_user_actor_tweet_verb(user:, actor:, tweet:, verb:) }

    context "when tweet activity exists" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:actor) { FactoryBot.create(:user) }
      let!(:tweet) { FactoryBot.create(:tweet, user:, created_at: 3.minutes.ago) }
      let!(:verb) { Constants::TweetActivity::VERBS[:liked] }

      context "user have tweet activity" do
        let!(:tweet_activity) { FactoryBot.create(:tweet_activity, user:, actor:, tweet:, verb: Constants::TweetActivity::VERBS[:liked]) }

        it "create tweet" do
          expect(get_by_user_actor_tweet_verb).to eq(tweet_activity)
        end
      end

      context "user does not have tweet activity" do
        it "returns empty" do
          expect(get_by_user_actor_tweet_verb).to be_nil
        end
      end
    end

    context "when user does not exists" do
      context "user does not have tweets" do
        let!(:user) { "Test" }
        let!(:actor) { "Test" }
        let!(:tweet) { "Test" }
        let!(:verb) { Constants::TweetActivity::VERBS[:liked] }

        it "returns empty" do
          expect(get_by_user_actor_tweet_verb).to be_nil
        end
      end
    end
  end

  describe "#delete" do
    subject(:delete) { described_class.new.delete(id:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:actor) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user:, created_at: 3.minutes.ago) }
    let!(:verb) { Constants::TweetActivity::VERBS[:liked] }

    context "when tweet activity exists" do
      let!(:tweet_activity) { FactoryBot.create(:tweet_activity, user:, actor:, tweet:, verb: Constants::TweetActivity::VERBS[:liked]) }
      let(:id) { tweet_activity.id }

      it "delete tweet_activity" do
        expect { delete }.to change { TweetActivity.count }.by(-1)
      end
    end

    context "when tweet activity does not exists" do
      let(:id) { "test" }

      it "returns record invalid" do
        expect { delete }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
