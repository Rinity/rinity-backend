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
  test 'matches rides' do
    rr1 = rides(:request_1)
    rr2 = rides(:request_2)
    ro1 = rides(:offer_1)

    rr3 = rides(:request_3)
    rr4 = rides(:request_4)
    ro2 = rides(:offer_2)

    #assert ro1.connect(rr1)
    #assert ro1.connect(rr2)
    #assert_not ro2.connect(rr3)
    #assert_not ro2.connect(rr4)

    assert Ride.match_all_by_office(rr1.office)

    assert_not_nil Ride.find(rr1.id).ride_id, "#{rr1.id} request is not matched to #{ro1.id}"
    assert_not_nil Ride.find(rr2.id).ride_id, "#{rr2.id} request is not matched to #{ro1.id}"
    assert_equal Ride.find(rr1.id).ride_id, ro1.id
    assert_equal Ride.find(rr2.id).ride_id, ro1.id

    assert_nil Ride.find(rr3.id).ride_id
    assert_nil Ride.find(rr4.id).ride_id
    assert_empty Ride.find(ro2.id).ride_requests
  end
end
