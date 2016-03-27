class VenuesIndex < Chewy::Index
  define_type Venue do
    field :country
    field :name
    field :address
    field :location, type: 'geo_point', value: ->{ {lat: latitude, lon: longitude} }
    field :categories, value: ->(venue) { venue.categories.map(&:name) } # passing array values to index
  end
end
