module RateLimiter
  extend ActiveSupport::Concern

  included do

    def rate_limit
      total = Rails.cache.increment(key, 1)
      set_expiry if total == 1

      if total > max_requests = 100
        render plain: limit_exceeded, status: 429
      else
        yield
      end
    end

    private

    def set_expiry
      # If we inc the key - and it returns 1, then the key doesnt exist
      # i.e. it's expired, or was never set.
      Rails.cache.write(
        key, 1, raw: true, expires_in: 1.hour
      )
      cache_when_we_started_counting
    end

    def cache_when_we_started_counting
      # Not sure if its possible to get when an item is due for expiry
      # So we cache when we started counting requests for this IP.
      Rails.cache.write(
        key_first_request_time, Time.now.to_i, expires_in: 61.minutes
      )
    end

    def limit_exceeded
      "Rate limit exceeded. Try again in #{seconds_to_wait} seconds"
    end

    def seconds_to_wait
      first_request = Rails.cache.read( key_first_request_time ).to_i
      60*60 - (Time.now.to_i - first_request)
    end

    def key
      request.remote_ip
    end

    def key_first_request_time
      "#{key}_first_request"
    end
  end
end
