require "rails_helper"

RSpec.describe Likes::Commands::Create, "#call", :db do
  let(:command) { described_class.new }

  subject(:call) do
    command.call(tweet:, user:)
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user:) }

  it "create Like" do
    expect { call }.to change { Like.count }.by(1)
  end

  it "create Notification" do
    expect { call }.to change { Notification.count }.by(1)
  end

  it "create Tweet Activity" do
    expect { call }.to change { TweetActivity.count }.by(1)
  end
end
