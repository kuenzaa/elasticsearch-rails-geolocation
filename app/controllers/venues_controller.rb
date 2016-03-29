class VenuesController < ApplicationController
  def show
    if params[:term].nil?
      @venues = []
    else
      term = params[:term]

      res = Geocoder.search(term)
      @location = res.first.geometry['location'] # lat / lng

      scope = VenuesIndex
        .filter {match_all}
        .filter(geo_distance: {
          distance: "2km",
          location: {lat: @location['lat'], lon: @location['lng']}
        })
        .order(_geo_distance: {
            location: {lat: @location['lat'], lon: @location['lng']}
          })
      @total_count = scope.total_count
      @venues = scope.load

    end
  end
end
