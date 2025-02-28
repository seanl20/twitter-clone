require "rails_helper"

RSpec.describe Tweets::Commands::Create, "#call", :db do
  let(:create) { described_class.new }

  subject(:call) do
    create.call(params:, user:)
  end

  let!(:user) { FactoryBot.create(:user) }

  before do
    allow(TweetActivity::TweetedJob).to receive(:perform_later)
  end

  context "when called" do
    let(:params) do
      {
        body: "Test Tweet Body"
      }
    end

    it "queues up TweetActivity::TweetedJob" do
      call

      tweet = Tweet.last

      expect(TweetActivity::TweetedJob).to have_received(:perform_later).with(actor: user, tweet:)
    end
  end
end
