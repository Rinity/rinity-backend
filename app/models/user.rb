class User < ActiveRecord::Base
  validates_presence_of :name, :email, :address, :city, :company, :default_office
  validates_associated :company, :default_office
  belongs_to :company
  belongs_to :default_office, :class_name => Office
end
