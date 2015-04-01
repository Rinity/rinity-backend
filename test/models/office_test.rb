require 'test_helper'

class OfficeTest < ActiveSupport::TestCase
  test 'empty office' do
    assert Office.new.valid? == false, 'empty office can\'t be valid'
  end
  test 'office belongs to company' do
    assert Office.new(name: '1', address: 'hq').valid? == false, 'office has to belong to company'
  end
  test 'has name address and company' do
    assert Office.new(name: 'HQ', address: 'Infinit Loop 1', company: Company.first).valid? == true
  end
end
