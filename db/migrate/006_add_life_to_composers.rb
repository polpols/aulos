class AddLifeToComposers < ActiveRecord::Migration
  def self.up
    add_column :composers, :life, :string
  end

  def self.down
    remove_column :composers, :life
  end
end