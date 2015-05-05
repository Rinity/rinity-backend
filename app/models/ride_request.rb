# ride_request.rb
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
    time_distance = (ro.time - time).abs < 15.minutes
    connect_offer(ride) if time_distance && same_way(ride)
  end

  def same_way(ride_offer)
    ride_offer.freeSeats > 0 && direction == ride_offer.direction && toCity == ride_offer.toCity && fromCity == ride_offer.fromCity && office_id == ride_offer.office_id
  end

  def connect_offer(offer)
    self.ride_offer = offer
    self.status = 'active'
    offer.status = 'active'
    offer.decrement(:freeSeats)
    offer.save && save
  end
end
