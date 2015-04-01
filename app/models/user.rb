class User < ActiveRecord::Base
  validates_presence_of :name, :email, :address, :city, :company
  validates_associated :company
  belongs_to :company
end
