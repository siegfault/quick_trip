# frozen_string_literal: true

require_relative '../../lib/api_clients/air_labs'
require_relative '../../lib/api_clients/radar'

require 'active_support/core_ext/module/delegation'

# Main runner that coordinates configured options for flights
class RouteFetcher
  def initialize(destination:, origin:, range:)
    @destination = APIClients::Radar.new.geocode(address: destination)
    @origin = origin
    @range = range
  end

  def plan
    # require "pry"; binding.pry
    puts destination_airports
  end

  private

  attr_reader :destination, :origin, :range

  delegate :latitude, :longitude, to: :destination, prefix: true

  def destination_airports
    @destination_airports ||= APIClients::AirLabs.new(
      latitude: destination_latitude,
      longitude: destination_longitude,
      range:
    ).airports
  end

  def destination_latitude
    destination['latitude']
  end

  def destination_longitude
    destination['longitude']
  end
end
