class Url < ActiveRecord::Base

  private

  # test existance of a url by connecting to it
  def valid_url(url)
    require 'open-uri'
    begin
      open url
    rescue
      return false
    end
    true
  end

end
