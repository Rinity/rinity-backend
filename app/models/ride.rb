# ride.rb
class Ride < ActiveRecord::Base
  #   t.string :direction
  #   t.datetime :time
  #   t.string :type ==> 'Request' | 'Offer'
  #   t.integer :freeSeats
  #   t.string :fromAddress
  #   t.string :toAddress
  #   t.string :fromCity
  #   t.string :toCity
  #   t.integer :user_id ==> belongs_to
  #   t.integer :office_id ==> belongs_to
  #   t.string :status ==> waiting | active | closed | canceled
  #   t.integer :ride_id ==> set if ride is associated
  validates :direction, :time, :type, :user, :office, presence: true
  # validates_presence_of :fromAddress, :fromCity, :toAddress, :toCity

  validates :office, :user, presence: true
  validates_associated :office, :user

  belongs_to :office
  belongs_to :user
  # scope :requests, -> { where(type: 'RideRequest') }
  # scope :offers, -> { where(type: 'RideOffer') }
  scope :waiting, -> { where(status: 'waiting') }
  scope :active, -> { where(status: 'active') }
  scope :closed, -> { where(status: 'closed') }
  scope :canceled, -> { where(status: 'canceled') }

  validate :check_user_has_default_office
  before_validation :set_default_office_if_not_set
  before_validation :set_type
  before_create :set_address

  attr_accessor :from_address, :to_address
  # This helps controllers know what type of resource to talk to
  # See more: http://www.alexreisner.com/code/single-table-inheritance-in-rails
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Ride.model_name
      end
    end
    super
  end

  def self.select_options
    descendants.map(&:to_s).sort
  end

  def self.direction_options
    %w(to_home to_office)
  end

  def office_options
    user.company.offices.sort
  end

  def check_user_has_default_office
    errors.add(:office, 'has no default without user') if office.nil? && user && user.default_office.nil?
  end

  def set_default_office_if_not_set
    self.office = user.default_office if user && user.default_office && office.nil?
  end

  def set_type
    self.type = user.type == 'Passenger' ? 'RideRequest' : 'RideOffer' if user.present?
  end

  def set_address
    if 'to_home' == direction
      self.from_address = office
      self.to_address = user
    else # to_office
      self.from_address = user
      self.to_address = office
    end
    self.status = 'waiting'
  end

  def cancel
    self.status = 'canceled'
    save
  end

  def from_address
    if 'to_home' == direction
      "#{office.name} (#{office.address}, #{office.city})"
    else
      "#{user.address}, #{user.city}"
    end
  end

  def from_address=(addressable)
    self.fromAddress = addressable.address
    self.fromCity = addressable.city
  end

  def to_address
    if 'to_home' == direction
      "#{user.address}, #{user.city}"
    else
      "#{office.name} (#{office.address}, #{office.city})"
    end
  end

  def to_address=(addressable)
    self.toAddress = addressable.address
    self.toCity = addressable.city
  end

  def self.match_all
    @office = Office.all
    # iterate all offices
    @office.each do |office|
      logger.info "Processing office #{office.name} (#{office.address})"
      match_all_by_office(office)
    end
    true
  end

  def self.match_all_by_office(office)
    office.ride_requests.each do |request|
      offer = office.ride_offers.for_request(request)
      if offer.any?
        request.connect(offer.take)
      else
        request.update_attribute(:status, 'error')
      end
    end
  end
end
