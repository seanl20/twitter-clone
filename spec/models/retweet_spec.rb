require 'rails_helper'

RSpec.describe Retweet, type: :model do
  it { is_expected.to belong_to :tweet }
  it { is_expected.to belong_to :user }
end
