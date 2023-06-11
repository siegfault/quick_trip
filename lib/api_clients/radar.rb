# frozen_string_literal: true

require 'httparty'

module APIClients
  # Interact with the Radar API to geocode addresses
  class Radar
    include HTTParty
    base_uri 'https://api.radar.io/v1'

    def initialize
      self.class.headers 'Authorization' => ENV.fetch('RADAR_TEST_PUBLISHABLE')
    end

    def geocode(address:)
      self.class.get('/geocode/forward', query: { query: address }).dig('addresses', 0)
    end
  end
end
