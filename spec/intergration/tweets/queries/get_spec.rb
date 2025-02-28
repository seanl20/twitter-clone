require "rails_helper"

RSpec.describe Tweets::Queries::Get, "#call", :db do
  let(:get) { described_class.new }

  subject(:call) do
    get.call(id:, user:)
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user:) }

  before do
    allow(ViewTweetJob).to receive(:perform_later)
  end

  context "when tweet exists" do
    let(:id) { tweet.id }

    it "return tweet as tweet presenter tweet" do
      expect(call.tweet).to eq(tweet)
    end

    it "queues up view tweet job" do
      call

      expect(ViewTweetJob).to have_received(:perform_later).with(tweet:, user:)
    end
  end

  context "when tweet does not exists" do
    let(:id) { "Test" }

    it "returns record not found" do
      expect { call }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
