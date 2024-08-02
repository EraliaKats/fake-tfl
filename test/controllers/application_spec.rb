# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "#get_arrivals" do

    context "successful response" do

      before do
        stub_request(:get, 'https://api.tfl.gov.uk/StopPoint/940GZZLUGPS')
          .with(headers: { 'Cache-Control' => 'no-cache' })
          .to_return(status: 200)
      end

        it "returns a successful response" do
          get :index
          expect(response).to be_successful
        end
      end
    end
end
