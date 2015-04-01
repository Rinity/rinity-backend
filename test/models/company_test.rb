require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'cannot be empty' do
    assert Company.new.valid? == false, 'company is valid without name and address'
  end
  test 'has at least one office' do
    company = Company.new(name: 'Rinity', address: 'Over the rainbow', domain: 'rinity.com')
    assert company.valid? == false, 'company is valid without an office'
    assert_includes company.errors.full_messages, 'Offices can\'t be blank', 'company has at least one office'
  end
  test 'has name address domain and office' do
    company = Company.new(name: 'Rinity', address: 'Over the rainbow', domain:'rinity.com', offices_attributes:[{name: 'HQ', address: 'Archam City'}])
    assert company.valid? == true, company.errors.full_messages
  end
  test 'company has many employees' do
    company = Company.new(name: 'Rinity', address: 'Over the rainbow', domain: 'rinity.com')
    assert_empty company.employees, 'has many employees'
  end
end
