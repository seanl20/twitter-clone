require "rails_helper"

RSpec.describe Repositories::MentionRepo do
  describe "#find_or_create" do
    subject(:find_or_create) { described_class.new.find_or_create(attrs:) }

    context "when mention does not exist" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:tweet) { FactoryBot.create(:tweet) }

      let(:attrs) do
        {
          mentioned_user: user,
          tweet:
        }
      end

      it "create mention" do
        expect { find_or_create }.to change { Mention.count }.by(1)
      end
    end

    context "when mention already exist" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:tweet) { FactoryBot.create(:tweet) }

      let!(:mention) { FactoryBot.create(:mention, mentioned_user: user, tweet:) }

      let(:attrs) do
        {
          mentioned_user: user,
          tweet:
        }
      end

      it "returns hashtag" do
        expect { find_or_create }.to change { Hashtag.count }.by(0)
        expect(find_or_create).to eq(mention)
      end
    end
  end
end
