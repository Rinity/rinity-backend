class User < ActiveRecord::Base
  validates_presence_of :name, :email, :address, :city, :company
  validates_uniqueness_of :email
  validates_associated :company
  belongs_to :company, inverse_of: :employees
  belongs_to :default_office, :class_name => Office, inverse_of: :employees

  before_validation :assign_company_and_set_passenger, :on => :create

  # To have a default office
  # validates_presence_of :name, :email, :address, :city, :company, :default_office
  # validates_associated :company, :default_office
  # belongs_to :company
  # belongs_to :default_office, :class_name => Office

  def assign_company_and_set_passenger
    self.type= 'Passenger'
    if self.email
      domain = self.email.split('@')[1]
      company = Company.find_or_initialize_by(domain: domain)
      if company.new_record?
        logger.debug 'creating company with '+domain
        company.name= domain
        company.address= 'unknown'
      end
      self.company = company
      self.default_office = company.offices.first if self.default_office.nil?
    else
      false
    end
  end
end
