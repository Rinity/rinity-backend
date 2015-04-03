json.extract! @user, :id, :name, :email, :address, :city, :created_at, :updated_at, :type, :company, :ride_requests
json.extract! @user.company, :id, :name, :domain, :address, :offices, :created_at, :updated_at
json.offices(@user.company.offices) do |office|
  json.id office.id
  json.name office.name
  json.address office.address
end
json.mates(@user.company.employees) do |employee|
  json.extract! employee, :id, :name
end
# json.rides(@user.ride_requests) do |ride|
#   json.extract! ride, :id, :direction, :time, :type, :freeSeats, :fromAddress, :toAddress, :fromCity, :toCity, :user_id, :status, :ride_id, :created_at, :updated_at
# end