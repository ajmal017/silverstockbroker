class PagesController < ApplicationController
  def index
    @commentaries = Commentary.all
  end
end
