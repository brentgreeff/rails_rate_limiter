RSpec.describe "Homes", type: :request do

  describe "GET /homes" do
    before { get '/home' }

    it "returns OK" do
      expect( response.body ).to match /OK/
      expect( response ).to have_http_status(200)
    end
  end
end
