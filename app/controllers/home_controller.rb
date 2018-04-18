class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to users_path
    end
  end
end
