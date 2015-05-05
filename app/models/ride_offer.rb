# ride_offer.rb
class RideOffer < Ride
  belongs_to :driver, class_name: Driver
  belongs_to :office, inverse_of: :ride_offers
  has_many :ride_requests, foreign_key: :ride_id
  has_many :passengers, through: :ride_requests, source: :user

  validates :direction, :time, :type, :user, :office, presence: true
  validates_associated :office, :user
  # validates_each :freeSeats do |record, attr, value|
  #  record.errors.add attr, 'must be at least 0'  if value < 0
  # end
  scope :has_free_seat, -> { where('freeSeats > 0') }
  scope :for_request, ->(request) { where(direction: request.direction, toCity: request.toCity, time: (request.time - 15.minutes)..(request.time + 15.minutes)) }

  # returns true if rides can be connected false if not
  # rides can connect if
  # - going the same direction
  # - in 15 minutes window
  # - has free seats
  # - going to/from the same office
  # - fromCity is the same
  # - toCity is the same
  def connect(ride)
    # ride = ride.becomes(RideRequest)
    time_distance = (ride.time - time).abs < 15.minutes
    connect_request(ride) if time_distance && same_way(ride)
  end

  def same_way(ride_request)
    freeSeats > 0 && direction == ride_request.direction && toCity == ride_request.toCity && fromCity == ride_request.fromCity && office_id == ride_request.office_id
  end

  def connect_request(request)
    ride_requests << request
    request.status = 'active'
    self.status = 'active'
    decrement(:freeSeats)
    request.save && save
  end
  # def connect(ride)
  #  rr = ride.becomes(RideRequest)
  #  time_distance = (rr.time - time).abs < 15.minutes
  #  if freeSeats > 0 && time_distance && direction == rr.direction && toCity == rr.toCity && fromCity == rr.fromCity && office_id == rr.office_id
  #    ride_requests << rr
  #    rr.status = 'active'
  #    self.status = 'active'
  #    decrement(:freeSeats)
  #    if rr.save && save
  #      true
  #    else
  #      false
  #    end
  #  else
  #    logger.error 'Cannot connect ride'
  #    logger.error "free seats: #{freeSeats > 0}"
  #    logger.error "time distance: #{time_distance}"
  #    logger.error "direction: #{direction == rr.direction}"
  #    logger.error "to city: #{toCity == rr.toCity}"
  #    logger.error "from city: #{fromCity == rr.fromCity}"
  #    logger.error "office: #{office_id == rr.office_id}"
  #    false
  #  end
  # end
end
