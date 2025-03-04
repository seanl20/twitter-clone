require "rails_helper"

RSpec.describe Retweets::Commands::Delete, "#call", :db do
  let(:command) { described_class.new }

  subject(:call) do
    command.call(tweet:, id:, user:)
  end

  context "User and tweet has been passed" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user:) }

    let!(:retweet) { FactoryBot.create(:retweet, user:, tweet:) }
    let!(:tweet_activity) { FactoryBot.create(:tweet_activity, user:, actor: user, tweet:, verb: Constants::TweetActivity::VERBS[:retweeted]) }

    let!(:id) { retweet.id }

    it "creates reply tweet" do
      expect { call }.to change { Retweet.count }.by(-1)
    end

    it "creates tweet activity" do
      expect { call }.to change { TweetActivity.count }.by(-1)
    end
  end
end
