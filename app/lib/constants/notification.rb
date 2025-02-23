# frozen_string_literal: true

module Constants
  module Notification
    VERBS_VALIDATION = %w[followed-me liked-tweet metioned-me]

    VERBS = {
      follow: "followed-me",
      liked: "liked-tweet",
      metioned: "metioned-me"
    }
  end
end
