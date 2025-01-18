require "rails_helper"

RSpec.describe Tweets::Queries::Get, "#call", :db do
  let(:get) { described_class.new }

  subject(:call) do
    get.call(id:, user:)
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user:) }

  context "when tweet exists" do
    let(:id) { tweet.id }

    it "return tweet as tweet presenter tweet" do
      expect(call.tweet).to eq(tweet)
    end

    context "when view exists" do
      let!(:view) { FactoryBot.create(:view, tweet:, user:) }

      it "create view" do
        expect { call }.to change { View.count }.by(0)
      end
    end

    context "when view doesn't exists" do
      it "create view" do
        expect { call }.to change { View.count }.by(1)
      end
    end
  end

  context "when tweet does not exists" do
    let(:id) { "Test" }

    it "returns record not found" do
      expect { call }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
