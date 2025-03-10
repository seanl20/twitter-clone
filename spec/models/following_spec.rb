require 'rails_helper'

RSpec.describe Following, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:following_user).class_name("User") }
end
