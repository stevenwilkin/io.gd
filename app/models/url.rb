class Url < ActiveRecord::Base

  # the latest short_url created
  def self.last_short_url
    sql = <<-END_SQL
      SELECT
        *
      FROM
        urls
      ORDER BY
        LENGTH(short_url) DESC, short_url DESC
      LIMIT 1
    END_SQL
    find_by_sql(sql)
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
  def self.convert_from_base62(s)
  	if s.length == 1
  		$chars.index(s)
  	else
  		last = s.slice(s.length-1, 1)
  		remainder = s.slice(0, s.length-1)
  		self.convert_from_base62(last) + ($chars.length * self.convert_from_base62(remainder))
  	end
  end

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
