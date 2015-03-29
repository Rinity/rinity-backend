require 'test_helper'

class RideTest < ActiveSupport::TestCase
  test "empty ride is invalid" do
    assert Ride.new.valid? == false, 'empty ride should be invalid'
  end
end
