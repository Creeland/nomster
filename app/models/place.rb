class Place < ActiveRecord::Base
  belongs_to :user 
  # designates that the Place can have many comments tied to it. 
  has_many :comments
  has_many :photos

  # Geocode
  geocoded_by :address
  after_validation :geocode # auto fetch cooridinates

  # Checks if a data is present in each form field before the data is submitted
  # Also checks if the length meets the requirments 
  validates :description, :address, :name, presence: true, length: {minimum: 3}
end
