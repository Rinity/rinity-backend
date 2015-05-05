# rides_helper.rb
module RidesHelper
  def format_ride(ride)
    "#{ride.status}: #{ride.user.name} (#{ride.user.email}) goes from #{ride.from_address} to #{ride.to_address}"
  end
end
