require 'rubygems'
require 'httparty'

class ApplicationController < ActionController::Base
  include HTTParty

  def index
    @predicted_arrivals ||= get_arrivals
  end

  private

  def get_arrivals
    begin
      # StopPoint ID for Great Portland Street is 940GZZLUGPS
      response = HTTParty.get('https://api.tfl.gov.uk/StopPoint/940GZZLUGPS',
                              headers: { 'Cache-Control' => 'no-cache' })
      if response.success?
        response.parsed_response
      end
    rescue StandardError => e
      puts "Something went wrong #{e.message}."
    end
  end
end
