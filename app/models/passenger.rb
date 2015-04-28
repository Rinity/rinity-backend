class Passenger < User
  has_many :ride_requests, foreign_key: :user_id

  def becomes_driver
    self.becomes(Driver)
    self.save
  end
end