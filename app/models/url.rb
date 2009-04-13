class Url < ActiveRecord::Base

  # hack so model can be provided with domain the app is running on
  attr_accessor :host

  after_create :generate_short_url  # assign the short_url once we have an id

  attr_accessible :url  # the only user-specifiable attribute

  validates_presence_of :url

  # don't accept a url on this domain
  # test existance of a url by connecting to it
  validates_each :url, :allow_blank => true do |record, attr, value|
    if record.host && value =~ /#{record.host}(\/.*)?/
      record.errors.add attr, 'is already shortened'
    else
      require 'open-uri'
      begin
        open value
      rescue
        record.errors.add attr, 'is unreachable'
      end
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

  # generate a short_url according to the id of the Url
  def generate_short_url
    self.update_attribute :short_url, self.class.convert_to_base62(self.id)
  end

end
