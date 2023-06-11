# frozen_string_literal: true

# An airport stores data about its distance to the target
class Airport
  def initialize(name:, distance:, iata_code: nil, icao_code: nil)
    @distance = distance
    @iata_code = iata_code
    @icao_code = icao_code
    @name = name
  end

  def to_s
    "#{distance} - #{name}"
  end

  private

  attr_reader :distance, :iata_code, :icao_code, :name
end
