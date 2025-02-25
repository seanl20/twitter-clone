require 'rails_helper'

RSpec.describe Mention, type: :model do
  it { is_expected.to belong_to :tweet }
  it { is_expected.to belong_to(:mentioned_user).class_name("User") }
end
