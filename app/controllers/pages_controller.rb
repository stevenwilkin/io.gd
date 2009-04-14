class PagesController < ApplicationController

  def fourohfour
    @request_url = request.url
    render :fourohfour, :status => 404
  end

end
