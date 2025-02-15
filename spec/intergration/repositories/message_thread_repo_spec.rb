require "rails_helper"

RSpec.describe Repositories::MessageThreadRepo do
  describe "#create" do
    subject(:create) { described_class.new.create }

    context "when valid attrs are passed" do
      it "create message thread" do
        expect { create }.to change { MessageThread.count }.by(1)
      end
    end
  end

  describe "#get" do
    subject(:get) { described_class.new.get(id:) }

    context "message thread exists" do
      let!(:message_thread) { FactoryBot.create(:message_thread) }

      context "when valid id are passed" do
        let(:id) { message_thread.id }

        it "get message thread" do
          expect(get).to eq(message_thread)
        end
      end

      context "when invalid id are passed" do
        let(:id) { "test" }

        it "returns record not found" do
          expect { get }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "user does not exists" do
      let(:id) { 1 }

      it "returns record not found" do
        expect { get }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#get_by_ids" do
    subject(:get_by_ids) { described_class.new.get_by_ids(ids:) }

    context "when mutliple message thread exists" do
      let!(:message_thread_1) { FactoryBot.create(:message_thread) }
      let!(:message_thread_2) { FactoryBot.create(:message_thread) }
      let!(:message_thread_3) { FactoryBot.create(:message_thread) }
      let!(:message_thread_4) { FactoryBot.create(:message_thread) }

      context "when valid id are passed" do
        let(:ids) { [ message_thread_1.id, message_thread_2.id, message_thread_3.id, message_thread_4.id ] }

        it "get_by_ids message thread" do
          expect(get_by_ids).to match_unordered_elements(message_thread_1, message_thread_2, message_thread_3, message_thread_4)
        end
      end

      context "when invalid id are passed" do
        let(:ids) { "test" }

        it "returns empty" do
          expect(get_by_ids).to be_empty
        end
      end
    end

    context "message thread does not exists" do
      let(:ids) { 1 }

      it "returns empty" do
        expect(get_by_ids).to be_empty
      end
    end
  end
end
