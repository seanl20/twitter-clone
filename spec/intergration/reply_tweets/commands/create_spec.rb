require "rails_helper"

RSpec.describe ReplyTweets::Commands::Create, "#call", :db do
  let(:command) { described_class.new }

  subject(:call) do
    command.call(params:, user:, tweet:)
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user:) }

  context "params has been passed" do
    let(:params) do
      {
        body: "Test"
      }
    end

    it "creates reply tweet" do
      expect { call }.to change { Tweet.count }.by(1)
    end

    it "creates tweet activity" do
      expect { call }.to change { TweetActivity.count }.by(1)
    end
  end

  context "params is empty" do
    let(:params) do
      {
        body: ""
      }
    end

    it "does not create reply tweet" do
      expect { call }.to change { Tweet.count }.by(0)
    end

    it "does not create tweet activity" do
      expect { call }.to change { TweetActivity.count }.by(0)
    end
  end
end
