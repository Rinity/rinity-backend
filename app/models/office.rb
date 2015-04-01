class Office < ActiveRecord::Base
  validates_presence_of :name, :address, :company
  belongs_to :company, inverse_of: :offices
  has_many :employees, class_name: User
end
