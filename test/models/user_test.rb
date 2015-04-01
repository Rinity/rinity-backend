require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not be empty' do
    user= User.new
    assert user.valid? == false, 'empty user is invalid'
  end
  test 'should be valid' do
    user= User.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: Company.first})
    assert user.valid? == true, 'user is valid'
  end
  test 'user must belong to company' do
    user= User.create({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere'})
    assert user.valid? == false, 'user can exists without a company'
  end
  test 'registered user is passenger' do
    user= Passenger.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: Company.first})
    assert user.type == 'Passenger', 'registered user is passenger'
  end
end
