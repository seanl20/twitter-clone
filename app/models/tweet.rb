class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 280 }
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user
  has_many :views, dependent: :destroy
  has_many :viewed_users, through: :views, source: :user
  belongs_to :parent_tweet,
              inverse_of: :reply_tweets,
              foreign_key: :parent_tweet_id,
              class_name: "Tweet",
              optional: true,
              counter_cache: :reply_tweets_count
  has_many :reply_tweets, foreign_key: :parent_tweet_id, class_name: "Tweet"
  has_and_belongs_to_many :hashtags
  has_many :mentions, dependent: :destroy
  has_many :mentioned_users, through: :mentions

  before_save :parse_and_save_hashtags

  def parse_and_save_hashtags
    matches = body.scan(Constants::Regexp::HASHTAG_REGEX)
    return if matches.empty?

    matches.flatten.each do |tag|
      attrs = { tag: tag.delete("#") }

      hashtags << Repositories::HashtagRepo.new.find_or_create(attrs:)
    end
  end

  after_save :parse_and_save_mentions

  def parse_and_save_mentions
    matches = body.scan(Constants::Regexp::MENTIONS_REGEX)
    return if matches.empty?

    matches.flatten.each do |mention|
      mentioned_user = Repositories::UserRepo.new.get_by_username(username: mention.delete("@"))

      next if mentioned_user.blank?
      next if mentions.exists?(mentioned_user:)

      mentions.create(mentioned_user:)

      notification_attrs = {
        user: mentioned_user,
        actor: user,
        verb: Constants::Notification::VERBS[:mentioned]
      }

      Repositories::NotificationRepo.new.create(attrs: notification_attrs)
    end
  end
end
