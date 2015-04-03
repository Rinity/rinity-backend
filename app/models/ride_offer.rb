class RideOffer < Ride
  belongs_to :driver, :class_name => Driver
  belongs_to :office, inverse_of: :ride_offers
  has_many :ride_requests, foreign_key: :ride_id
  has_many :passengers, through: :ride_requests, source: :user

  # returns true if rides can be connected false if not
  # rides can connect if
  # - going the same direction
  # - in 15 minutes window
  # - has free seats
  # - going to/from the same office
  # - fromCity is the same
  # - toCity is the same
  def connect(ride)
    rr = ride.becomes(RideRequest)
    time_distance = (rr.time - self.time).abs < 15.minutes
    if self.freeSeats > 0 && time_distance && self.direction == rr.direction && self.toCity == rr.toCity && self.fromCity == rr.fromCity && self.office_id == rr.office_id
      self.ride_requests << rr
      rr.status = 'active'
      self.decrement(:freeSeats)
      rr.save
      self.save
    else
      false
    end
  end

end