class UrlsController < ApplicationController

  def new
  end

  def show
    url = Url.find_by_short_url(params[:short_url])
    if url
      redirect_to url.url, :status => 301
    else
      @invalid_url = request.url
      render :not_found, :status => 404
    end
  end

end
