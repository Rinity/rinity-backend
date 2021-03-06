class RideOffer < Ride
  belongs_to :driver, class_name: Driver
  belongs_to :office, inverse_of: :ride_offers
  has_many :ride_requests, foreign_key: :ride_id
  has_many :passengers, through: :ride_requests, source: :user

  validates_presence_of :direction, :time, :type, :user, :office
  validates_associated :office, :user
  #validates_each :freeSeats do |record, attr, value|
  #  record.errors.add attr, 'must be at least 0'  if value < 0
  #end
  scope :has_free_seat, -> {where('freeSeats > 0')}

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
      self.status = 'active'
      self.decrement(:freeSeats)
      if rr.save && self.save
        true
      else
        false
      end
    else
      puts 'Cannot connect ride'
      puts "free seats: #{self.freeSeats > 0}"
      puts "time distance: #{time_distance}"
      puts "direction: #{self.direction == rr.direction}"
      puts "to city: #{self.toCity == rr.toCity}"
      puts "from city: #{self.fromCity == rr.fromCity}"
      puts "office: #{self.office_id == rr.office_id}"
      false
    end
  end

end