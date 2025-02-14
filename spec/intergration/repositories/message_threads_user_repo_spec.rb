require "rails_helper"

RSpec.describe Repositories::MessageThreadsUserRepo do
  describe "#get_all_by_user" do
    subject(:get_all_by_user) { described_class.new.get_all_by_user(user:) }

    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }

    context "when message threads user exists" do
      let!(:message_threads_user_1) { FactoryBot.create(:message_threads_user, user: user_1) }
      let!(:message_threads_user_2) { FactoryBot.create(:message_threads_user, user: user_1) }
      let!(:message_threads_user_3) { FactoryBot.create(:message_threads_user, user: user_1) }
      let!(:message_threads_user_4) { FactoryBot.create(:message_threads_user, user: user_2) }

      let!(:user) { user_1 }

      it "returns all message threads user records linked to user" do
        expect(get_all_by_user.pluck(:user_id)).to match_unordered_elements(user_1.id, user_1.id, user_1.id)
      end
    end

    context "when message threads user exists" do
      let!(:user) { user_1 }

      it "returns record invalid" do
        expect(get_all_by_user).to be_empty
      end
    end
  end
end
