require "rails_helper"

RSpec.describe Repositories::MessageRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:message_thread) { FactoryBot.create(:message_thread) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          body: "test",
          message_thread:,
          user:
        }
      end

      it "create message" do
        expect { create }.to change { Message.count }.by(1)
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
end
