class UrlsController < ApplicationController

  def new
    @new_url = Url.new
  end

  def create
    @new_url = Url.new(params[:url])
    @new_url.host = request.host_with_port  # allow model to check app's domain
    if @new_url.save
      render :shortened
    else
      render :new
    end
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
