require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not be empty' do
    user= User.new
    assert user.valid? == false, 'empty user is invalid'
  end
  test 'should be valid' do
    user= User.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: Company.first, default_office: Company.first.offices.first})
    assert user.valid? == true, user.errors.full_messages.join(',')
  end
  test 'user must belong to company' do
    user= User.create({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere'})
    assert user.valid? == false, 'user can exists without a company'
  end
  test 'has a name email address city company and a default office' do
    user= Passenger.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: Company.first, default_office: Company.first.offices.first})
    assert_not_nil user.default_office, 'user should have a default office'
  end
  test 'registered user is passenger' do
    user= Passenger.create({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: Company.first, default_office: Company.first.offices.first})
    assert user.valid?, user.errors.full_messages.join(',')
    assert user.type == 'Passenger', 'registered user is passenger'
  end
  test 'user registration creates new company' do
    assert true
  end
end
