require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:tweets).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:liked_tweets).through(:likes).source(:tweet) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }

  describe "#set_display_name" do
    context "when display_name is set" do
      let!(:user) { FactoryBot.create(:user, username: "test", display_name: "Test Account") }

      it "does not change the display name" do
        user.save
        expect(user.reload.display_name).to eq("Test Account")
      end
    end

    context "when display_name is not set" do
      context "when display_name is set" do
        let!(:user) { FactoryBot.create(:user, username: "test", display_name: nil) }

        it "humanize the previously set username" do
          user.save

          expect(user.reload.display_name).to eq("Test")
        end
      end
    end
  end
end
