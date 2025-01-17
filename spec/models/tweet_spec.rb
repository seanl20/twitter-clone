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
end
