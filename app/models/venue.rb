class Venue < ActiveRecord::Base
  has_and_belongs_to_many :categories

  def distance location
    Geocoder::Calculations.distance_between([latitude, longitude], [location['lat'], location['lng']])
  end
end
