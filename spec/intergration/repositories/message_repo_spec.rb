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

  describe "#get_by_message_thread" do
    subject(:get_by_message_thread) { described_class.new.get_by_message_thread(message_thread:) }

    context "when mutliple message thread exists" do
      context "when valid id are passed" do
        let!(:message_thread) { FactoryBot.create(:message_thread) }
        let!(:message_1) { FactoryBot.create(:message, message_thread:) }
        let!(:message_2) { FactoryBot.create(:message, message_thread:) }
        let!(:message_3) { FactoryBot.create(:message, message_thread:) }
        let!(:message_4) { FactoryBot.create(:message, message_thread:) }

        it "return message from message thread" do
          expect(get_by_message_thread).to match_unordered_elements(message_1, message_2, message_3, message_4)
        end
      end

      context "when invalid id are passed" do
        let(:message_thread) { nil }

        it "returns empty" do
          expect(get_by_message_thread).to be_empty
        end
      end
    end

    context "message thread does not exists" do
      let(:message_thread) { 1 }

      it "returns empty" do
        expect(get_by_message_thread).to be_empty
      end
    end
  end
end
