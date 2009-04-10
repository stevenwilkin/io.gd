class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls do |t|
      t.string :short_url, :null => false
      t.string :url, :null => false
    end
    add_index :urls, :short_url, :unique => true
  end

  def self.down
    drop_table :urls
  end
end
