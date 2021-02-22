module Acars

  class Transmitter
    require 'net/http'
    require 'uri'
    RADAR_DOMAIN = "https://sfr-radar.herokuapp.com"
    KEY = ENV['ACARS_KEY']

    def initialize(app_name, dry_run: false)
      @app_name = app_name
      @dry_run = dry_run
    end

    def gauge(stats)
      if !stats.is_a?(Hash) || (stats.values.any? { |v| v.class != Integer && v.to_s.strip !~ /\d+/ })
        raise "Gauge data must be a hash of name-value pairs, and the values must be integers."
      end

      stats.each do |name, value|
        begin
          path = "/metrics/gauges/#{@app_name}/#{name}/#{value}"
          if @dry_run
            puts "(Dry run) ACARS would transmit: #{name}=#{value}"
          else
            puts "Transmitting ACARS: #{name}=#{value}"
            response = Net::HTTP.post URI(RADAR_DOMAIN + path), "key=#{Transmitter::KEY}"
            if ![200..299].include?(response.code)
              puts "ACARS ERROR: #{response.code}: #{response.body}"
            end
          end
        rescue => e
          puts "ACARS ERROR: #{e}"
        end
      end
    end

  end


end