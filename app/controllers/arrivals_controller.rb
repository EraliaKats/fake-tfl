require 'rubygems'
require 'httparty'

class ArrivalsController < ApplicationController
  include HTTParty

  def index
    @predicted_arrivals ||= get_arrivals unless flash[:error]
  end

  private

  def get_arrivals
    begin
      # StopPoint ID for Great Portland Street is 940GZZLUGPS
      response = HTTParty.get('https://api.tfl.gov.uk/StopPoint/940GZZLUGPS/Arrivals',
                              headers: { 'Cache-Control' => 'no-cache' })

      if response.success?
        response.parsed_response
      else
        flash[:error] = response["message"]
      end
    rescue StandardError => e
      flash[:error] = "Something went wrong: #{e.message}."
    end
  end
end
