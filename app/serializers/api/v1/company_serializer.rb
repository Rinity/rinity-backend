module Api
  module V1
    # company_serializer.rb
    class CompanySerializer < Api::V1::BaseSerializer
      attributes :id, :name, :domain, :address
      has_many :offices
      #  has_many :employees
    end
  end
end
