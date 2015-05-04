class Office < ActiveRecord::Base
  validates :name, :address, :city, :company, presence: true
  belongs_to :company, inverse_of: :offices
  has_many :employees, class_name: User, inverse_of: :default_office, foreign_key: :default_office_id
  has_many :ride_requests, -> { where(status: 'waiting') }, inverse_of: :office
  has_many :ride_offers, -> { where('status != \'fulfilled\' AND freeSeats > 0') }, inverse_of: :office
  def to_s
    [self.name,[self.address,self.city].join(',')].join('/')
  end
end
