# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ArrivalsController, type: :controller do
  describe "#get_arrivals" do

    context "successful response" do

      before do
        stub_request(:get, "https://api.tfl.gov.uk/StopPoint/940GZZLUGPS/Arrivals")
          .with(
            headers: { 'Cache-Control'=>'no-cache' })
          .to_return(status: 200, body: "", headers: {})

        get :index
      end

        it "returns a successful response" do
          expect(response).to be_successful
        end
      end
    end

    context "returns some error" do

      before do
        allow(HTTParty)
          .to receive(:get)
          .and_return(double(success?: false, response: {"message" => "smth's wrong"}))
      end

      # TODO: finish error spec
      it "renders index with error message" do
        get :index
        expect(flash[:error]).to eql("smth's wrong")
      end
    end
end
