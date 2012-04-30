class AddOriginToComposers < ActiveRecord::Migration
  def self.up
    add_column :composers, :origin, :string
  end

  def self.down
    remove_column :composers, :source
  end
end