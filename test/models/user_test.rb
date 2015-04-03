require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not be empty' do
    user= User.new
    assert user.invalid?, 'empty user is invalid'
  end
  test 'should be valid' do
    @company = companies(:itsh)
    user= User.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: @company, default_office: @company.offices.first})
    assert user.valid?, user.errors.full_messages.join(',')
  end
  test 'must have unique email' do
    @company = companies(:itsh)
    user_old= User.create({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: @company, default_office: @company.offices.first})
    user_new= User.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: @company, default_office: @company.offices.first})
    assert user_old.valid?
    assert user_new.invalid?, 'can create user with same email?'
    assert_includes user_new.errors.full_messages, 'Email has already been taken'
  end
  test 'user creates company based on domain' do
    assert_nil Company.find_by_domain('example.com')
    user= User.create({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere'})
    assert_not_nil Company.find_by_domain('example.com')
    assert user.valid?, 'user can exists without a company'
  end
  test 'has a name email address city company and a default office' do
    @company = companies(:itsh)
    user= Passenger.new({name: 'bob', email: 'bob@example.com', address: '55 main street', city: 'somewhere', company: @company, default_office: @company.offices.first})
    assert_not_nil user.default_office, 'user should have a default office'
  end
  test 'registered user is passenger' do
    @company = companies(:itsh)
    user= Passenger.create({name: 'bob', email: 'bob@'+@company.domain, address: '55 main street', city: 'somewhere', company: @company, default_office: @company.offices.first})
    assert user.valid?, user.errors.full_messages.join(',')
    assert user.type == 'Passenger', 'registered user is passenger'
  end
  test 'user registration creates new company' do
    assert true
  end
end
