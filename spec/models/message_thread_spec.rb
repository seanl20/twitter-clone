require 'rails_helper'

RSpec.describe MessageThread, type: :model do
  it { is_expected.to have_and_belong_to_many(:users) }
  it { is_expected.to have_many(:messages) }
end
