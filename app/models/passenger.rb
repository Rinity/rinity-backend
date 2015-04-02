class Passenger < User
  has_many :ride_requests, :foreign_key => :user_id
end