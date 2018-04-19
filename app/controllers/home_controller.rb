class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to users_feed_path
    end
  end
end
