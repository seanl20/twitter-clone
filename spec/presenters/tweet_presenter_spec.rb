require 'rails_helper'

RSpec.describe TweetPresenter, :freeze_time, type: :presenter do
  describe "#created_at" do
    let!(:user) { FactoryBot.create(:user) }

    context "when 24 hours have passed" do
      before do
        freeze_time Time.utc(2008, 9, 3)
      end

      after do
        unfreeze_time
      end

      let!(:tweet) { FactoryBot.create(:tweet, user:, created_at: 2.days.ago) }

      it "displays the shortened date format" do
        expect(TweetPresenter.new(tweet:, current_user: user).created_at).to eq("Sep 1")
      end
    end

    context "only a few hours have past" do
      let!(:tweet) { FactoryBot.create(:tweet, user:, created_at: 2.hours.ago) }

      it "displays how many hours have past" do
        expect(TweetPresenter.new(tweet:, current_user: user).created_at).to eq("about 2 hours")
      end
    end
  end
end
