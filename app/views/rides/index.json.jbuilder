json.array!(@rides) do |ride|
  json.extract! ride, :id, :direction, :time, :type, :freeSeats, :fromAddress, :toAddress, :fromCity, :toCity, :user_id, :status, :ride_id
  json.url ride_url(ride, format: :json)
end
