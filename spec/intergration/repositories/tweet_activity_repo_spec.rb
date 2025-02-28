require "rails_helper"

RSpec.describe Repositories::TweetActivityRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          user: user_1,
          actor: user_2,
          tweet:,
          verb: Constants::TweetActivity::VERBS[:tweeted]
        }
      end

      it "create notification" do
        expect { create }.to change { TweetActivity.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          user: user_1
        }
      end

      it "returns record invalid" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
