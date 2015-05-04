require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'cannot be empty' do
    assert Company.new.valid? == false, 'company is valid without name and address'
  end
  # it can't happen when user registers
  # test 'has at least one office' do
  #   company = Company.new(name: 'Rinity', address: 'Over the rainbow', domain: '_rinity.com')
  #   assert company.valid? == false, 'company is valid without an office'
  #   assert_includes company.errors.full_messages, 'Offices can\'t be blank', 'company has at least one office'
  # end
  test 'has name address domain and office' do
    company = Company.new(name: 'Rinity', address: 'Over the rainbow', domain:'_rinity.com', offices_attributes:[{ name: 'HQ', address: 'Archam', city: 'Gotham City' }])
    assert company.valid? == true, company.errors.full_messages
  end
  test 'company has many employees' do
    company = Company.new(name: 'Rinity', address: 'Over the rainbow', domain: '_rinity.com')
    assert_empty company.employees, 'has many employees'
  end
end
