class RideRequest < Ride
  belongs_to :passenger, class_name: Passenger
  belongs_to :office, inverse_of: :ride_requests
  belongs_to :ride_offer, foreign_key: :ride_id
  has_one :driver, through: :ride_offer, source: :user

  validates_presence_of :direction, :time, :type, :user, :office
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
      self.status= 'active'
      ro.status= 'active'
      ro.decrement(:freeSeats)
      if ro.save && self.save
        true
      else
        puts ro.errors.full_messages
        puts self.errors.full_messages
        false
      end
    else
      puts 'Cannot connect ride'
      puts "free seats: #{self.freeSeats > 0}"
      puts "time distance: #{time_distance}"
      puts "direction: #{self.direction == ro.direction}"
      puts "to city: #{self.toCity == ro.toCity}"
      puts "from city: #{self.fromCity == ro.fromCity}"
      puts "office: #{self.office_id == ro.office_id}"
      false
    end
  end

end