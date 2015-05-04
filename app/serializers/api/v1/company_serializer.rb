class Api::V1::CompanySerializer < Api::V1::BaseSerializer
  attributes :id, :name, :domain, :address
  has_many :offices
#  has_many :employees
end
