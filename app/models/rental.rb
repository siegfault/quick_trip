# frozen_string_literal: true

# Hours for a rental car location
class Rental
  def initialize(name:, periods:)
    @name = name
    @periods = periods || {}
  end

  def to_s
    "#{name} - #{closing_times}"
  end

  private

  attr_reader :name, :periods

  def closing_times
    periods.each_with_object({}) do |period, hash|
      hash[period.dig('close', 'time')] ||= []
      hash[period.dig('close', 'time')] << period.dig('close', 'date')
    end
  end
end
