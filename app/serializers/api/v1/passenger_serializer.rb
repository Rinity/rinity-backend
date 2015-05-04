module Api
  module V1
    # passenger_serializer.rb
    class PassengerSerializer < Api::V1::BaseSerializer
      attributes :id, :type, :email, :name, :address, :city # , :coworkers

      has_one :company # belongs_to is not in AMS 0.9.3
      has_one :default_office # belongs_to is not in AMS 0.9.3
      has_many :ride_requests
      #  def coworkers
      #    self.company.employees
      #  end
    end
  end
end
