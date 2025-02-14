require 'rails_helper'

RSpec.describe MessageThreadsUser, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:message_thread) }
end
