class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls do |t|
      t.string :url, :null => false
      t.string :short_url, :limit => 5
    end

    add_index :urls, :short_url, :unique => true
  end

  def self.down
    drop_table :urls
  end
end
