class AddSourceToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :source, :string
  end

  def self.down
    remove_column :works, :source
  end
end