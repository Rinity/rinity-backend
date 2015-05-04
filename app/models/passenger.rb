# passenger.rb
class Passenger < User
  has_many :ride_requests, foreign_key: :user_id

  def becomes_driver
    becomes(Driver)
    save
  end
end
