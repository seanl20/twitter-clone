class TweetActivity < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :verb, presence: true, inclusion: { in: Constants::TweetActivity::VERBS_VALIDATION }
end
