require 'active_support/testing/time_helpers'

module Test
  module TimeHelpers
    def freeze_time(time = Time.current)
      travel_to time
    end

    def unfreeze_time
      travel_back
    end
  end
end

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers, :freeze_time
  config.include Test::TimeHelpers, :freeze_time

  config.before :each do
    freeze_time if respond_to?(:freeze_time)
  end

  config.after :each do
    unfreeze_time if respond_to?(:unfreeze_time)
  end
end
