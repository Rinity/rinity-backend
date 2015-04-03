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
  validates_presence_of :direction, :time, :type, :user, :office
  # validates_presence_of :fromAddress, :fromCity, :toAddress, :toCity
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
  before_create :set_address

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
    descendants.map { |c| c.to_s }.sort
  end

  def self.direction_options
    ['to_home', 'to_office']
  end

  def office_options
    self.user.company.offices.sort
  end

  def check_user_has_default_office
    self.errors.add(:office, 'has no default without user') if self.office.nil? && self.user && self.user.default_office.nil?
  end

  def set_default_office_if_not_set
    if self.user && self.user.default_office && self.office.nil?
      self.office = self.user.default_office
    end
  end

  def set_address
    if 'to_home' == self.direction
      self.fromAddress = self.office.address
      self.fromCity = self.office.city
      self.toAddress = self.user.address
      self.toCity = self.user.city
    else # to_office
      self.fromAddress = self.user.address
      self.fromCity = self.user.city
      self.toAddress = self.office.address
      self.toCity = self.office.city
    end
    self.status= 'waiting'
  end

  def cancel
    self.status = 'canceled'
    self.save
  end

  def self.match_all
    @office = Office.all
    # iterate all offices
    @office.each do |office|
      logger.debug "Processing office #{office.name} (#{office.address})"

      @request = office.ride_requests

      %w(to_home to_office).each do |direction|

        logger.debug "Processing direction #{direction}"

        one_way = @request.where(direction: direction)
        one_way.each do |request|

          logger.debug "Processing request: #{request.id}"
          offer = office.ride_offers.where(direction: direction, tocity: request.toCity, time: (request.time - 15.minutes)..(request.time + 15.minutes))
          logger.debug offer
          if offer.first
            logger.debug "Found offer #{offer.first.id}"
            request.connect(offer.first)
          end
          logger.debug 'done'

        end

      end

    end
    true
  end
end
