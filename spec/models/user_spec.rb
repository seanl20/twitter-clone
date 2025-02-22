require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:tweets).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:liked_tweets).through(:likes).source(:tweet) }
  it { is_expected.to have_many(:bookmarks).dependent(:destroy) }
  it { is_expected.to have_many(:bookmarked_tweets).through(:bookmarks).source(:tweet) }
  it { is_expected.to have_many(:retweets).dependent(:destroy) }
  it { is_expected.to have_many(:retweeted_tweets).through(:retweets).source(:tweet) }
  it { is_expected.to have_many(:views) }
  it { is_expected.to have_many(:viewed_tweets).through(:views).source(:tweet) }
  it { is_expected.to have_many(:followings).dependent(:destroy) }
  it { is_expected.to have_many(:following_users).through(:followings).source(:following_user) }
  it { is_expected.to have_many(:reverse_followings).with_foreign_key(:following_user_id).class_name("Following") }
  it { is_expected.to have_many(:followers).through(:reverse_followings).source(:user) }
  it { is_expected.to have_many(:messages) }
  it { is_expected.to have_and_belong_to_many(:message_threads) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }

  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }

  describe "#set_display_name" do
    context "when display_name is set" do
      let!(:user) { FactoryBot.create(:user, username: "test", display_name: "Test Account") }

      it "does not change the display name" do
        user.save
        expect(user.reload.display_name).to eq("Test Account")
      end
    end

    context "when display_name is not set" do
      context "when display_name is set" do
        let!(:user) { FactoryBot.create(:user, username: "test", display_name: nil) }

        it "humanize the previously set username" do
          user.save

          expect(user.reload.display_name).to eq("Test")
        end
      end
    end
  end
end
