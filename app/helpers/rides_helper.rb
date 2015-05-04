# rides_helper.rb
module RidesHelper
  def format_ride(ride)
    ret = "#{ride.status}: #{ride.user.name} (#{ride.user.email}) goes from "
    if ride.direction == 'to_home'
      "#{ret} #{ride.office.name} (#{ride.office.address}, #{ride.office.city}) to #{ride.user.address}, #{ride.user.city}"
    else
      "#{ret} #{ride.user.address}, #{ride.user.city} to #{ride.office.name} (#{ride.office.address}, #{ride.office.city}"
    end
  end
end
