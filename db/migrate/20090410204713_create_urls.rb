class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls do |t|
      t.string :url, :null => false
    end
    # need case-sensitivity for short_url column
    execute "ALTER TABLE urls ADD COLUMN short_url VARBINARY(5) NOT NULL AFTER id"
    add_index :urls, :short_url, :unique => true
  end

  def self.down
    drop_table :urls
  end
end
