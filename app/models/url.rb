class Url < ActiveRecord::Base

  attr_accessible :url  # the only user-specifiable attribute

  validates_presence_of :url

  # test existance of a url by connecting to it
  validates_each :url, :allow_nil => true do |record, attr, value|
    require 'open-uri'
    begin
      open value
    rescue
      record.errors.add attr, "Can't connect to URL"
    end
  end


  private

  # short_urls are effectively base-62 numbers comprising the following chars (in ASCII order)
  $chars = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
  
  # convert a base-10 number to "base-62" string
  def self.convert_to_base62(n)
  	if n < $chars.length
  		$chars[n].to_s
  	else
  		quotient = n / $chars.length
  		remainder = n % $chars.length
  		self.convert_to_base62(quotient) + self.convert_to_base62(remainder) 
  	end
  end

  # convert a "base-62" string to a base-10 number
  # this is not actually used, here just for reference
  def self.convert_from_base62(s)
  	if s.length == 1
  		$chars.index(s)
  	else
  		last = s.slice(s.length-1, 1)
  		remainder = s.slice(0, s.length-1)
  		self.convert_from_base62(last) + ($chars.length * self.convert_from_base62(remainder))
  	end
  end

end
