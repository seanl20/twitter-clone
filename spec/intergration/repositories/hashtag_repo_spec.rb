require "rails_helper"

RSpec.describe Repositories::HashtagRepo do
  describe "#find_or_create" do
    subject(:find_or_create) { described_class.new.find_or_create(attrs:) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          tag: "test"
        }
      end

      it "find_or_create hashtag" do
        expect { find_or_create }.to change { Hashtag.count }.by(1)
      end
    end

    context "when hashtag already exist" do
      let!(:hashtag) { FactoryBot.create(:hashtag, tag: "test") }

      let(:attrs) do
        {
          tag: "test"
        }
      end

      it "returns hashtag" do
        expect { find_or_create }.to change { Hashtag.count }.by(0)
        expect(find_or_create).to eq(hashtag)
      end
    end
  end
end
