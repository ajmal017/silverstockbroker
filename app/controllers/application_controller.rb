class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  @stocks = Stock.all

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
end
