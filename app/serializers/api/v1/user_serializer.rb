class Api::V1::UserSerializers < Api::V1::BaseSerializer
  attributes :id, :type, :email, :name, :address, :city#, :coworkers

  has_one :company # belongs_to is not in AMS 0.9.3
  has_one :default_office #belongs_to is not in AMS 0.9.3

  def created_at
    object.created_at.in_time_zone.iso8601 if object.created_at
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if object.created_at
  end

  def coworkers
    self.company.employees
  end
end
