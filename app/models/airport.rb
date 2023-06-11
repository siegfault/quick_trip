# frozen_string_literal: true

require_relative '../../lib/api_clients/google'

# An airport stores data about its distance to the target
class Airport
  def initialize(name:, distance:, iata_code: nil, icao_code: nil)
    @distance = distance
    @iata_code = iata_code
    @icao_code = icao_code
    @name = name
  end

  def to_s
    <<~TO_S
      #{name}
        * #{car_rentals.join("\n  * ")}
    TO_S
  end

  private

  attr_reader :distance, :iata_code, :icao_code, :name

  def car_rentals
    APIClients::Google.new.car_rentals(name)
  end
end
