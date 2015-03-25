require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not be empty" do
    user= User.new
    assert user.valid? == false, 'empty user is invalid'
  end
  test 'should be valid' do
    user= User.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere'})
    assert user.valid? == true, 'user is valid'
  end
  test 'registered user is passenger' do
    user= Passenger.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere'})
    assert user.type == 'Passenger', 'registered user is passenger'
  end
end
