class VenuesController < ApplicationController
  def show
    if params[:term].nil?
      @venues = []
    else
      @location = address_to_geolocation params[:term]
      @category = params[:category]

      scope = search_by_location
      @total_count = scope.total_count
      @venues = scope.load
    end
  end

  private
    def address_to_geolocation term
      res = Geocoder.search(term)
      res.first.geometry['location'] # lat / lng
    end

    def search_by_location
      scope = VenuesIndex
        .filter {match_all}
        .filter(geo_distance: {
          distance: "2km",
          location: {lat: @location['lat'], lon: @location['lng']}
        })
        .order(_geo_distance: {
            location: {lat: @location['lat'], lon: @location['lng']}
          })

      if @category
        scope = scope.merge(VenuesIndex.filter(match: {categories: @category}))
      end

      return scope
    end
end
