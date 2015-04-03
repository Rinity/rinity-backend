class MatchRidesJob < ActiveJob::Base
  RUN_EVERY = 5.minutes
  queue_as :default

  def perform(*args)
    logger.debug 'Matching rides...'
    Ride.match_all
    self.class.perform_later(wait: RUN_EVERY)
    logger.debug 'Matching rides done'
  end

end
