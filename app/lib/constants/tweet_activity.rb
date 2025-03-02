# frozen_string_literal: true

module Constants
  module TweetActivity
    VERBS_VALIDATION = %w[tweeted liked replied retweeted]

    VERBS = {
      tweeted: "tweeted",
      liked: "liked",
      replied: "replied",
      retweeted: "retweeted"
    }

    VERBS_RENDER = %w[liked replied retweeted]
  end
end
