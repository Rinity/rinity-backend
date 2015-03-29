class RideRequest < Ride
  belongs_to :passenger, :class_name => Passenger
end