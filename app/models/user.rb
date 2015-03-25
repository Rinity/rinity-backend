class User < ActiveRecord::Base
  validates_presence_of :name, :email, :address, :city
end
