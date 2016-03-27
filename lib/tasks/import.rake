namespace :import do
  desc "Import venues from foursquare"
  task :venues, [:near] => :environment do |t, args|

    client = Foursquare2::Client.new(
      client_id: '',
      client_secret: '',
      api_version: '20160325')

    result = client.search_venues(near: args[:near].to_s, query: 'restaurants', intent: 'browse')
    result.venues.each do |v|
        venue_object = Venue.new(name: v.name, address: v.location.address, country: v.location.country, latitude: v.location.lat, longitude: v.location.lng)

        v.categories.each do |c|
          venue_object.categories << Category.find_or_create_by(name: c.pluralName)
        end

        venue_object.save

        puts "'#{venue_object.name}' - imported"
    end
  end
end
