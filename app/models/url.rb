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
