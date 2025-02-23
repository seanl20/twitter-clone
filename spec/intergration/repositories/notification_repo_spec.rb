require "rails_helper"

RSpec.describe Repositories::NotificationRepo do
  describe "#create" do
    subject(:create) { described_class.new.create(attrs:) }

    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }

    context "when valid attrs are passed" do
      let(:attrs) do
        {
          actor: user_1,
          user: user_2,
          verb: Constants::Notification::VERBS[:follow]
        }
      end

      it "create notification" do
        expect { create }.to change { Notification.count }.by(1)
      end
    end

    context "when invalid attrs are passed" do
      let(:attrs) do
        {
          user: user_1
        }
      end

      it "returns record invalid" do
        expect { create }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#get_by_user" do
    subject(:get_by_user) { described_class.new.get_by_user(user:) }

    context "when user exists" do
      let!(:user_1) { FactoryBot.create(:user) }
      let!(:user_2) { FactoryBot.create(:user) }

      context "user have notifications" do
        let!(:notification_1) { FactoryBot.create(:notification, user: user_1, actor: user_2, created_at: 3.minutes.ago) }
        let!(:notification_2) { FactoryBot.create(:notification, user: user_1, actor: user_2, created_at: 2.minutes.ago) }
        let!(:notification_3) { FactoryBot.create(:notification, user: user_2, actor: user_1, created_at: 1.minutes.ago) }
        let!(:user) { user_1 }

        it "return notifications tweet" do
          expect(get_by_user).to match_ordered_elements(notification_2, notification_1)
        end
      end

      context "user does not have tweets" do
        let!(:user) { user_1 }

        it "returns record invalid" do
          expect(get_by_user).to be_empty
        end
      end
    end

    context "when user does not exists" do
      context "user does not have notifications" do
        let!(:user) { "Test" }

        it "returns record invalid" do
          expect(get_by_user).to be_empty
        end
      end
    end
  end
end
