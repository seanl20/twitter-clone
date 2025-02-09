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


  describe "#get_all" do
    subject(:get_all) { described_class.new.get_all }

    context "when multiple hashtags exists" do
      let!(:hashtag_1) { FactoryBot.create(:hashtag, tag: "test") }
      let!(:hashtag_2) { FactoryBot.create(:hashtag, tag: "time") }

      it "returns hashtags" do
        expect(get_all).to match_unordered_elements(hashtag_1, hashtag_2)
      end
    end

    context "when no hashtags exists" do
      it "return empty" do
        expect(get_all).to be_empty
      end
    end
  end
end
