# user.rb
class User < ActiveRecord::Base
  validates :name, :email, :address, :city, :company, presence: true
  validates :email, uniqueness: true
  validates_associated :company
  has_many :rides
  has_many :offices, through: :company
  belongs_to :company, inverse_of: :employees
  belongs_to :default_office, class_name: Office, inverse_of: :employees

  before_validation :assign_company_and_set_passenger, on: :create
  before_create :generate_authentication_token
  # To have a default office
  # validates_presence_of :name, :email, :address, :city, :company, :default_office
  # validates_associated :company, :default_office
  # belongs_to :company
  # belongs_to :default_office, :class_name => Office

  def assign_company_and_set_passenger
    self.type = 'Passenger'
    if email
      domain = email.split('@')[1]
      company = Company.find_or_initialize_by(domain: domain)
      if company.new_record?
        logger.debug 'creating company with ' + domain
        company.name = domain
        company.address = 'unknown'
        company.city = city
      end
      self.company = company
      self.default_office = company.offices.first if default_office.nil?
    else
      false
    end
  end

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(64)
      break unless User.find_by(authentication_token: authentication_token)
    end
  end

end
