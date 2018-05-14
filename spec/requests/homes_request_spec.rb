RSpec.describe "Homes", type: :request do
  before { Rails.cache.clear }
  after { Rails.cache.clear }

  describe "GET /homes" do
    before { get '/home' }

    it "returns OK" do
      expect( response.body ).to match /OK/
      expect( response ).to have_http_status(200)
    end
  end

  context "When there are 100 requests" do
    before { Rails.cache.write('127.0.0.1', 100, raw: true) }

    context "and the first request was 59 minutes ago" do
      let(:fifty_nine_min_ago) { Time.now.to_i - (59*60) }

      before do
        Timecop.freeze(Time.now)
        Rails.cache.write('127.0.0.1_first_request', fifty_nine_min_ago)
      end

      context "making another request" do
        before { get '/home' }

        it "returns 429" do
          expect( response.body )
          .to match /Rate limit exceeded. Try again in 60 seconds/

          expect( response ).to have_http_status(429)
        end
      end
      after { Timecop.return }
    end
  end

  context "making the first request" do
    before { get '/home' }

    it "saves it as the first request for this ip" do
      expect(
        Rails.cache.read '127.0.0.1'
      ).to eq "1"
    end

    context "making second request" do
      before { get '/home' }

      it "saves it as the second request for this ip" do
        expect(
          Rails.cache.read '127.0.0.1'
        ).to eq "2"
      end
    end

    def spoof_ip
      {"REMOTE_ADDR" => "8.8.8.8"}
    end

    context "another request from a different person" do
      before { get '/home', headers: spoof_ip }

      it "leaves the first IP intact" do
        expect(
          Rails.cache.read '127.0.0.1'
        ).to eq "1"
      end
    end

    context "another request from a different person" do
      before { get '/home', headers: spoof_ip }

      it "sets the first request from 8.8.8.8" do
        expect(
          Rails.cache.read '8.8.8.8'
        ).to eq "1"
      end
    end
  end
end
