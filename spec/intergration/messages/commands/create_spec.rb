require "rails_helper"

RSpec.describe Messages::Commands::Create, "#call", :db do
  let(:command) { described_class.new }

  subject(:call) do
    command.call(params:, user_id:, current_user:)
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:current_user) { FactoryBot.create(:user) }

  context "when message thread does not exists" do
    context "params has been passed" do
      let(:user_id) { user.id }

      let(:params) do
        {
          body: "Test"
        }
      end

      it "create message" do
        expect { call }.to change { Message.count }.by(1)
      end

      it "create message thread" do
        expect { call }.to change { MessageThread.count }.by(1)
      end
    end
  end

  context "when message thread does exists" do
    let!(:message_thread) { FactoryBot.create(:message_thread) }

    let!(:message_threads_user_1) { FactoryBot.create(:message_threads_user, user:, message_thread:) }
    let!(:message_threads_user_2) { FactoryBot.create(:message_threads_user, user: current_user, message_thread:) }


    context "params has been passed" do
      let(:user_id) { user.id }

      let(:params) do
        {
          body: "Test"
        }
      end

      it "create message" do
        expect { call }.to change { Message.count }.by(1)
      end

      it "does not create message thread" do
        expect { call }.to change { MessageThread.count }.by(0)
      end
    end
  end

  context "params is empty" do
    let(:user_id) { user.id }

    let(:params) do
      {
        body: "",
        user_id: user.id
      }
    end

    it "returns failure" do
      expect { call }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
