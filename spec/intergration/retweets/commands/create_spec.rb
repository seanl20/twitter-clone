require "rails_helper"

RSpec.describe Retweets::Commands::Create, "#call", :db do
  let(:command) { described_class.new }

  subject(:call) do
    command.call(tweet:, user:)
  end

  context "User and tweet has been passed" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user:) }

    it "creates reply tweet" do
      expect { call }.to change { Retweet.count }.by(1)
    end

    it "creates tweet activity" do
      expect { call }.to change { TweetActivity.count }.by(1)
    end
  end

  context "User and tweet is empty" do
    let!(:user) { nil }
    let!(:tweet) { nil }

    it "does not create reply tweet" do
      expect { call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "does not create tweet activity" do
      expect { call }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
