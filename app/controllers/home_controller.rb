class HomeController < ApplicationController

  def index
    insta_service = Instagram::Api.new({ access_token: current_user.token})
    @pics = insta_service.feed_pics(true)
  end
end
