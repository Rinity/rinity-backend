# company.rb
class Company < ActiveRecord::Base
  validates :name, :address, :city, :domain, :offices, presence: true
  validates :domain, uniqueness: true
  validates_associated :offices
  has_many :employees, class_name: User, inverse_of: :company
  has_many :offices, inverse_of: :company
  accepts_nested_attributes_for :offices, reject_if: proc { |attributes| attributes['name'].blank? || attributes['address'].blank? }, allow_destroy: true
  before_validation :check_address, on: :create
  before_validation :check_name, on: :create
  before_validation :check_city, on: :create, if: proc { |model| model.city.nil? }
  before_validation :create_default_office

  # to have office associated
  # validates_presence_of :name, :address, :domain, :offices
  # validates_associated :offices
  # has_many :employees, :class_name => User
  # has_many :offices, inverse_of: :company
  # accepts_nested_attributes_for :offices, :reject_if => proc { |attributes| attributes['name'].blank? || attributes['address'].blank? }, :allow_destroy => true

  def create_default_office
    offices.new(name: 'Office', address: address, city: city) if offices.empty?
  end

  def check_address
    self.address = 'Unknown' if address.nil?
  end

  def check_name
    self.name = domain.capitalize if name.nil? && domain.present?
  end

  def check_city
    if employees.empty?
      self.city = 'Unknown'
    else
      self.city = employees.first.city
    end
  end
end
