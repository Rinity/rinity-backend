class RideRequest < Ride
  belongs_to :passenger, class_name: Passenger
  belongs_to :office, inverse_of: :ride_requests
  belongs_to :ride_offer, foreign_key: :ride_id
  has_one :driver, through: :ride_offer, source: :user

  validates :direction, :time, :type, :user, :office, presence: true
  validates_associated :office, :user

  scope :unmatched, -> { where(ride_id: nil) }

  # returns true if rides can be connected false if not
  # rides can connect if
  # - going the same direction
  # - in 15 minutes window
  # - has free seats
  # - going to/from the same office
  # - fromCity is the same
  # - toCity is the same
  def connect(ride)
    ro = ride.becomes(RideOffer)
    time_distance = (ro.time - self.time).abs < 15.minutes

    if ro.freeSeats > 0 && time_distance && self.direction == ro.direction && self.toCity == ro.toCity && self.fromCity == ro.fromCity && self.office_id == ro.office_id
      self.ride_offer = ro
      self.status = 'active'
      ro.status = 'active'
      ro.decrement(:freeSeats)
      if ro.save && self.save
        true
      else
        logger.error ro.errors.full_messages
        logger.error self.errors.full_messages
        false
      end
    else
      logger.error 'Cannot connect ride'
      logger.error "free seats: #{self.freeSeats > 0}"
      logger.error "time distance: #{time_distance}"
      logger.error "direction: #{self.direction == ro.direction}"
      logger.error "to city: #{self.toCity == ro.toCity}"
      logger.error "from city: #{self.fromCity == ro.fromCity}"
      logger.error "office: #{self.office_id == ro.office_id}"
      false
    end
  end

end