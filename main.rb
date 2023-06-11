# frozen_string_literal: true

require 'optparse'

require_relative 'app/models/route_fetcher'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: example.rb [options]'

  opts.on('-d', '--destination=DESTINATION', 'Destination')
  opts.on('-o', '--origin=ORIGIN',           'Point of origin')
  opts.on('-r', '--range=RANGE',             'Range around destination to search for airports')
end.parse!(into: options)

RouteFetcher.new(**options).plan
