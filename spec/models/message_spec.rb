require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :message_thread }
  it { should validate_presence_of(:body) }
end
