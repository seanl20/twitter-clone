require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { is_expected.to belong_to :user }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(280) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:liked_users).through(:likes).source(:user) }
  it { is_expected.to have_many(:bookmarks).dependent(:destroy) }
  it { is_expected.to have_many(:bookmarked_users).through(:bookmarks).source(:user) }
  it { is_expected.to have_many(:retweets).dependent(:destroy) }
  it { is_expected.to have_many(:retweeted_users).through(:retweets).source(:user) }
  it { is_expected.to have_many(:views).dependent(:destroy) }
  it { is_expected.to have_many(:viewed_users).through(:views).source(:user) }
  it { is_expected.to belong_to(:parent_tweet).with_foreign_key(:parent_tweet_id).class_name("Tweet").inverse_of(:reply_tweets).optional }
  it { is_expected.to have_many(:reply_tweets).with_foreign_key(:parent_tweet_id).class_name("Tweet") }
  it { should have_and_belong_to_many(:hashtags) }

  describe "#parse_and_save_hashtags" do
    let(:user) { FactoryBot.create(:user) }

    context "when there are no hashtags in body" do
      it "does not create any hashtags" do
        expect do
          Tweet.create(user:, body: "Hashtags Test Time")
        end.not_to change { Hashtag.count }
      end
    end

    context "when there are hashtags in body" do
      it "create hashtags" do
        expect do
          Tweet.create(user:, body: "Hashtags #Test #Time")
        end.to change { Hashtag.count }.by(2)
      end

      it "creates hashtags assigned to the tweet" do
        tweet = Tweet.create(user:, body: "Hashtags #Test #Time")
        expect(tweet.hashtags.size).to eq(2)
      end
    end

    context "when there are duplicate hashtags in body" do
      let(:hashtag) { FactoryBot.create(:hashtag, tag: "Time") }

      it "does not create extra hashtags if already in the database table" do
        hashtag

        expect do
          Tweet.create(user:, body: "Hashtags #Test #Time")
        end.to change { Hashtag.count }.by(1)
      end
    end
  end
end
