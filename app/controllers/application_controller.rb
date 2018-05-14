class ApplicationController < ActionController::API
  include RateLimiter
end
