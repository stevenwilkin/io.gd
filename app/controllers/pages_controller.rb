class PagesController < ApplicationController

  def fourohfour
    render :fourohfour, :status => 404
  end

end
