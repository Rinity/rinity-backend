class Company < ActiveRecord::Base
  validates_presence_of :name, :address, :domain, :offices
  validates_uniqueness_of :domain
  validates_associated :offices
  has_many :employees, class_name: User, inverse_of: :company
  has_many :offices, inverse_of: :company
  accepts_nested_attributes_for :offices, reject_if: proc { |attributes| attributes['name'].blank? || attributes['address'].blank?}, allow_destroy: true
  before_validation :create_default_office

  # to have office associated
  # validates_presence_of :name, :address, :domain, :offices
  # validates_associated :offices
  # has_many :employees, :class_name => User
  # has_many :offices, inverse_of: :company
  # accepts_nested_attributes_for :offices, :reject_if => proc { |attributes| attributes['name'].blank? || attributes['address'].blank? }, :allow_destroy => true

  def create_default_office
    if offices.empty?
      self.offices.new(name: 'Office', address: self.address, city: 'unknown')
    end
  end
end
