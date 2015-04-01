require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'cannot be empty' do
    assert Company.new.valid? == false, 'company is valid without name and address'
  end
  test 'has name and address and domain' do
    company = Company.new(name: 'Rinity', address: 'Over the rainbow', domain:'rinity.com')
    assert company.valid? == true, ''
  end
  test 'company has many employees' do
    company = Company.new(name: 'Rinity', address: 'Over the rainbow', domain: 'rinity.com')
    assert_empty company.employees, 'has many employees'
  end
end
