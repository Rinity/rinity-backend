module Api
  module V1
    # office_serializer.rb
    class OfficeSerializer < Api::V1::BaseSerializer
      attributes :id, :name, :address, :city
    end
  end
end
