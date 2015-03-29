class RideOffer < Ride
  belongs_to :driver, :class_name => Driver
end