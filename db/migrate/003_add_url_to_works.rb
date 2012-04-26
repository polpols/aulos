class AddUrlToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :url, :string
  end

  def self.down
    remove_column :works, :url
  end
end