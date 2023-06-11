# frozen_string_literal: true

require_relative '../../app/models/rental'

module APIClients
  # Get car rental information
  class Google
    include HTTParty
    base_uri 'https://maps.googleapis.com/maps/api'

    def initialize
      self.class.default_params key: ENV.fetch('GOOGLE_MAPS_API_KEY')
    end

    def car_rentals(location)
      rental_places(location).map do |place_id|
        place = self.class.get('/place/details/json', query: { place_id:, fields: rental_fields })
        Rental.new(name: place.dig('result', 'name'), periods: place.dig('result', 'current_opening_hours', 'periods'))
      end
    end

    private

    def rental_fields
      'current_opening_hours/periods/close,name'
    end

    def rental_places(location)
      self.class.get(
        '/place/findplacefromtext/json', query: {
          inputtype: :textquery,
          input: "#{location} Car Rental"
        }
      ).fetch('candidates').map { _1['place_id'] }
    end
  end
end
