module Api
  module V1
    # driver_serializer.rb
    class DriverSerializer < Api::V1::BaseSerializer
      attributes :id, :type, :email, :name, :address, :city # , :coworkers

      has_one :company # belongs_to is not in AMS 0.9.3
      has_one :default_office # belongs_to is not in AMS 0.9.3
      has_many :ride_offers
      #  def coworkers
      #    self.company.employees
      #  end
    end
  end
end
