require 'test_helper'

class OfficeTest < ActiveSupport::TestCase
  test 'empty office' do
    office = Office.new
    assert office.invalid?, 'empty office can\'t be valid'
    assert_includes office.errors.full_messages, 'Name can\'t be blank'
    assert_includes office.errors.full_messages, 'Address can\'t be blank'
    assert_includes office.errors.full_messages, 'City can\'t be blank'
    assert_includes office.errors.full_messages, 'Company can\'t be blank'
  end
  test 'office belongs to company' do
    assert Office.new(name: '1', address: 'hq', city: 'a').invalid?, 'office has to belong to company'
  end
  test 'has name address and city and company' do
    assert Office.new(name: 'HQ', address: 'Infinit Loop 1', city: 'Paolo Alto', company: Company.first).valid?
  end
end
