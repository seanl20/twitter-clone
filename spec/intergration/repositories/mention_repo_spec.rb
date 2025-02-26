require "rails_helper"

RSpec.describe Repositories::MentionRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

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
        expect { create }.to change { Mention.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          mentioned_user: nil
        }
      end

      it "returns record invalid" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
