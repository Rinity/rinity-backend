class Api::V1::RideSerializer < Api::V1::BaseSerializer
  embed :ids, include: true
  attributes :id, :type, :time, :freeSeats, :direction, :status, :fromAddress, :toAddress, :fromCity, :toCity
  has_one :user
  has_one :office
#  has_one :ride
end
