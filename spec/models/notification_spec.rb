require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:actor).class_name("User") }
  it { is_expected.to belong_to(:tweet).optional }

  it { should validate_presence_of(:verb) }
  it { should validate_inclusion_of(:verb).in_array(Constants::Notification::VERBS_VALIDATION) }
end
