# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'dotenv/load'
require 'httparty'

require_relative '../../app/models/airport'

module APIClients
  # Interface for AirLabs API to locate nearby airports
  class AirLabs
    include HTTParty
    base_uri 'https://airlabs.co/api/v9'

    def initialize(latitude:, longitude:, range:)
      self.class.default_params api_key: ENV.fetch('AIRLABS_API_KEY'), lat: latitude, lng: longitude, distance: range
    end

    def airports
      request.dig('response', 'airports').map do |airport_info|
        Airport.new(**airport_info.symbolize_keys.slice(:name, :iata_code, :icao_code, :distance))
      end
    end

    private

    def request
      self.class.get('/nearby')
    end
  end
end
