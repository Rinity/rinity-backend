class Company < ActiveRecord::Base
  validates_presence_of :name, :address, :domain
  has_many :employees, :class_name => User
end
