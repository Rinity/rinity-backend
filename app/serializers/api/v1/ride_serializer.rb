class Api::V1::RideSerializer < Api::V1::BaseSerializer
  attributes :id, :type, :direction, :from_address, :to_address, :from_city, :to_city
  has_one :user
  has_one :office
  has_one :ride
end
