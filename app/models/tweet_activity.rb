class TweetActivity < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  belongs_to :actor, class_name: "User"

  validates :verb, presence: true, inclusion: { in: Constants::TweetActivity::VERBS_VALIDATION }
end
