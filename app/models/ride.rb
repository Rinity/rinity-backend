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
#   t.string :status ==> waiting | active | fulfilled
#   t.integer :ride_id ==> set if ride is associated
  validates_presence_of :direction, :time, :type, :fromAddress, :fromCity, :toAddress, :toCity, :user_id

  # scope :requests, -> { where(type: 'RideRequest') }
  # scope :offers, -> { where(type: 'RideOffer') }

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
    ['to_home','to_office']
  end
end
