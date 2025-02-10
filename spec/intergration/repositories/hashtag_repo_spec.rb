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

  describe "#get_all_with_limit" do
    subject(:get_all_with_limit) { described_class.new.get_all_with_limit(limit:) }

    context "when multiple hashtags exists" do
      context "when limit is passed and more hashtag than limit existed" do
        let!(:hashtag_1) { FactoryBot.create(:hashtag, tag: "test") }
        let!(:hashtag_2) { FactoryBot.create(:hashtag, tag: "time") }
        let!(:hashtag_3) { FactoryBot.create(:hashtag) }
        let!(:hashtag_4) { FactoryBot.create(:hashtag) }

        let!(:limit) { 3 }

        it "returns hashtags" do
          expect(get_all_with_limit).to match_unordered_elements(hashtag_1, hashtag_2, hashtag_3)
          expect(get_all_with_limit.count).to eq(3)
        end
      end

      context "when limit is passed and less hashtag than limit existed" do
        let!(:hashtag_1) { FactoryBot.create(:hashtag, tag: "test") }
        let!(:hashtag_2) { FactoryBot.create(:hashtag, tag: "time") }

        let!(:limit) { 2 }

        it "returns hashtags" do
          expect(get_all_with_limit).to match_unordered_elements(hashtag_1, hashtag_2)
          expect(get_all_with_limit.count).to eq(2)
        end
      end

      context "when limit is nil" do
        let!(:hashtag_1) { FactoryBot.create(:hashtag, tag: "test") }
        let!(:hashtag_2) { FactoryBot.create(:hashtag, tag: "time") }
        let!(:hashtag_3) { FactoryBot.create(:hashtag) }
        let!(:hashtag_4) { FactoryBot.create(:hashtag) }
        let!(:hashtag_5) { FactoryBot.create(:hashtag) }

        let!(:limit) { nil }

        it "returns hashtags" do
          expect(get_all_with_limit).to match_unordered_elements(hashtag_1, hashtag_2, hashtag_3, hashtag_4, hashtag_5)
          expect(get_all_with_limit.count).to eq(5)
        end
      end
    end

    context "when no hashtags exists" do
      let!(:limit) { 2 }

      it "return empty" do
        expect(get_all_with_limit).to be_empty
      end
    end
  end

  describe "#get" do
    subject(:get) { described_class.new.get(id:) }

    context "hashtag exists" do
      let!(:hashtag) { FactoryBot.create(:hashtag) }

      context "when valid id are passed" do
        let(:id) { hashtag.id }

        it "get hashtag" do
          expect(get).to eq(hashtag)
        end
      end

      context "when invalid id are passed" do
        let(:id) { "test" }

        it "returns record not found" do
          expect { get }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "hashtag does not exists" do
      let(:id) { 1 }

      it "returns record not found" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
