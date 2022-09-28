require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade, vcr: { :match_requests_on => [:uri] } do
  let!(:coords) { [
    39.738453,
    -104.984853
  ] }
  let!(:units) { 'imperial' }

  describe "class methods" do
    describe "weather" do
      it "returns a forecast object" do
        forecast = ForecastFacade.weather(coords, units)
        expect(forecast).to be_a(Forecast)
      end
    end

    describe "current_conditions" do
      it "returns a current weather object" do
        current = ForecastFacade.current_conditions(coords)
        expect(current).to_not be_nil
        expect(current).to be_a(Hash)
        expect(current).to have_key(:dt)
        expect(current).to have_key(:sunrise)
        expect(current).to have_key(:sunset)
        expect(current).to have_key(:temp)
      end
    end
  end
end
