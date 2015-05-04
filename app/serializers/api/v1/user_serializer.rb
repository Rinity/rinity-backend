module Api
  module V1
    # user_serializer.rb
    class UserSerializer < Api::V1::BaseSerializer
      #  embed :ids, include: true
      attributes :id, :type, :email, :name, :address, :city

      # belongs_to is not in AMS 0.9.3
      has_one :company, embed: :ids
      # belongs_to is not in AMS 0.9.3
      has_one :default_office, embed: :ids, include: false

      #  def created_at
      #    object.created_at.in_time_zone.iso8601 if object.created_at
      #  end

      #  def updated_at
      #    object.updated_at.in_time_zone.iso8601 if object.created_at
      #  end
    end
  end
end
