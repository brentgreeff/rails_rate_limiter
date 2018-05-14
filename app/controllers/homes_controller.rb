class HomesController < ApplicationController

  def show
    rate_limit do
      render plain: 'OK'
    end
  end
end
