require "rails_helper"

RSpec.describe Repositories::BookmarkRepo do
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

      it "create bookmark" do
        expect { create }.to change { Bookmark.count }.by(1)
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

    let!(:bookmark) { FactoryBot.create(:bookmark, user:, tweet:) }

    context "when bookmark exists" do
      let(:id) { bookmark.id }

      it "delete tweet" do
        expect { delete_by_tweet }.to change { Bookmark.count }.by(-1)
      end
    end

    context "when bookmark does not exists" do
      let(:id) { "test" }

      it "returns record invalid" do
        expect { delete_by_tweet }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#get_tweets_by_user" do
    subject(:get_tweets_by_user) { described_class.new.get_tweets_by_user(user:) }

    context "when user exists" do
      let!(:user_1) { FactoryBot.create(:user) }
      let!(:user_2) { FactoryBot.create(:user) }

      let!(:user) { user_1 }

      context "user have tweets" do
        let!(:tweet_1) { FactoryBot.create(:tweet, user: user_1) }
        let!(:tweet_2) { FactoryBot.create(:tweet, user: user_1) }
        let!(:tweet_3) { FactoryBot.create(:tweet, user: user_1) }

        let!(:bookmark_1) { FactoryBot.create(:bookmark, user: user_1, tweet: tweet_1) }
        let!(:bookmark_2) { FactoryBot.create(:bookmark, user: user_1, tweet: tweet_2) }
        let!(:bookmark_3) { FactoryBot.create(:bookmark, user: user_2, tweet: tweet_3) }


        it "returns tweets that are bookmarked by the user" do
          expect(get_tweets_by_user).to match_unordered_elements(tweet_1, tweet_2)
        end
      end

      context "user does not have bookmarks" do
        it "returns record invalid" do
          expect(get_tweets_by_user).to be_empty
        end
      end
    end

    context "when user does not exists" do
      context "user does not have bookmarks" do
        let!(:user) { "Test" }

        it "returns record invalid" do
          expect(get_tweets_by_user).to be_empty
        end
      end
    end
  end
end
