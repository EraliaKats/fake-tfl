# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ArrivalsController, type: :controller do
  describe "#get_arrivals" do

    context "successful response" do

      before do
        stub_request(:get, "https://api.tfl.gov.uk/StopPoint/940GZZLUGPS/Arrivals")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Cache-Control'=>'no-cache',
            'User-Agent'=>'Ruby'
            })
          .to_return(status: 200, body: "", headers: {})
      end

        it "returns a successful response" do
          get :index
          expect(response).to be_successful
        end
      end
    end

    context "returns some error" do

      before do
        stub_request(:get, "https://api.tfl.gov.uk/StopPoint/nope/Arrivals")
          .with(
            headers: {
              'Cache-Control'=>'no-cache'
            })
          .to_return(status: 404)
      end

      # TODO: finish error spec
      it "renders index with error message" do
        get :index
        expect(error).to eql(flash[:error])
      end
    end
end
