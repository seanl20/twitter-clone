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

    context "user exists" do
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
end
