require 'rails_helper'

RSpec.describe TweetActivity::TweetedJob, type: :job do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user: user_1) }

  let!(:following) { FactoryBot.create(:following, user: user_2, following_user: user_1) }

  subject do
    described_class.new.perform(tweet:, actor: user_1)
  end

  context "creates a tweet activity" do
    it "change the tweet activity count" do
      expect { subject }.to change { TweetActivity.count }.by(1)
    end
  end
end
