require 'rubygems'
require 'httparty'

class ApplicationController < ActionController::Base
  include HTTParty

  def index
    @hello = "Hello World"
  end
end
