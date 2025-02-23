class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User"
  belongs_to :tweet, optional: true

  validates :verb, presence: true, inclusion: { in: Constants::Notification::VERBS_VALIDATION }
end
