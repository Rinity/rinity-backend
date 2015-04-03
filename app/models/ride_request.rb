class RideRequest < Ride
  belongs_to :passenger, class_name: Passenger
  belongs_to :office, inverse_of: :ride_requests
  belongs_to :ride_offer, foreign_key: :ride_id
  has_one :driver, through: :ride_offer, source: :user

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
      self.status= 'active'
      ro.freeSeats = ro.freeSeats-1
      ro.save
      self.save
    else
      false
    end
  end

end