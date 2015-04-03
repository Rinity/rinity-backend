require 'test_helper'

class RideTest < ActiveSupport::TestCase
  test 'empty ride is invalid' do
    ride = Ride.new
    assert ride.invalid?, 'empty ride should be invalid'
    assert_includes ride.errors.full_messages, 'Direction can\'t be blank'
    assert_includes ride.errors.full_messages, 'Time can\'t be blank'
    assert_includes ride.errors.full_messages, 'Type can\'t be blank'
    assert_includes ride.errors.full_messages, 'User can\'t be blank'
    assert_includes ride.errors.full_messages, 'Office can\'t be blank'
  end
  test 'sets default ride if none given' do
    user = users(:passenger_1)
    ride = user.ride_requests.new(time: Time.now, direction: 'to_home')
    assert_nil ride.office
    ride.save
    assert ride.valid?
    assert_not_nil ride.office
  end
  test 'sets office when given' do
    user = users(:passenger_1)
    ride = user.ride_requests.new(time: Time.now, direction: 'to_home', office: user.company.offices.last)
    ride.save
    assert ride.valid?
    assert_equal ride.office, user.company.offices.last
  end
end
