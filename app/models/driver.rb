class Driver < User
  has_many :ride_offers, foreign_key: :user_id
end