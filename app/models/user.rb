class User < ActiveRecord::Base
  validates_presence_of :name, :email, :address, :city, :company
  validates_associated :company
  belongs_to :company
  belongs_to :default_office, :class_name => Office

  before_create :assign_company_and_set_passenger

  # To have a default office
  # validates_presence_of :name, :email, :address, :city, :company, :default_office
  # validates_associated :company, :default_office
  # belongs_to :company
  # belongs_to :default_office, :class_name => Office

  def assign_company_and_set_passenger
    self.type= 'Passenger'
    domain = self.email.split('@')[1]
    company = Company.find_or_initialize_by(domain: domain)
    if company.new_record?
      company.name= domain
      company.address= 'unknown'
      company.save
    end
    self.company = company
  end
end
