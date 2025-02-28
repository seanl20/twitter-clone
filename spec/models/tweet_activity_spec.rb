require 'rails_helper'

RSpec.describe TweetActivity, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:tweet) }
  it { is_expected.to belong_to(:actor).class_name("User") }

  it { should validate_presence_of(:verb) }
end
