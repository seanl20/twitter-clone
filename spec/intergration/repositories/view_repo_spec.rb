require "rails_helper"

RSpec.describe Repositories::ViewRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user:) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          tweet:,
          user:
        }
      end

      it "create view" do
        expect { create }.to change { View.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          user:
        }
      end

      it "returns record invalid" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#exists?" do
    subject(:exists) { described_class.new.exists?(tweet:, user:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user:) }

    context "when view exists" do
      let!(:view) { FactoryBot.create(:view, tweet:, user:) }

      it "return true" do
        expect(exists).to be true
      end
    end

    context "when view does not exists" do
      it "return false" do
        expect(exists).to be false
      end
    end
  end
end
