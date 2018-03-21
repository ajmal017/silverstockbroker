class DashboardController < ApplicationController
  before_action  :authenticate_user!
  
  def index
  end

  def commentary
    @commentaryNew = Commentary.new
    @commentaries = Commentary.all
  end

  def symbols
    @stockNew = Stock.new
    @stocks = Stock.all
  end
end
