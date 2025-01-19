require 'rails_helper'

RSpec.describe ViewTweetJob, type: :job do
  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user:) }

  subject do
    described_class.new.perform(tweet:, user:)
  end

  context "creates a view record when tweet has not been viewed" do
    it "change the view count" do
      expect { subject }.to change { View.count }.by(1)
    end
  end

  context "does not creates a view record when tweet has already been viewed" do
    let!(:view) { FactoryBot.create(:view, tweet:, user:) }

    it "does not change the view count" do
      expect { subject }.to change { View.count }.by(0)
    end
  end
end
