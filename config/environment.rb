# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# MatchRidesJob.set(wait: 5.minutes).perform_later(:perform)