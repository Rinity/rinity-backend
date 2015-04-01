class Company < ActiveRecord::Base
  validates_presence_of :name, :address, :domain, :offices
  validates_associated :offices
  has_many :employees, :class_name => User
  has_many :offices, inverse_of: :company
  accepts_nested_attributes_for :offices, :limit => 1, :reject_if => :all_blank
end
