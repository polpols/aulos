class CreateComposers < ActiveRecord::Migration
  def self.up
    create_table :composers do |t|
      t.column :name, :string, :null => false
      t.column :surname, :string, :null => false
      t.column :url, :string, :null => false
      t.column :pict, :string, :null => false
    end
  end

  def self.down
    drop_table :users
  end
end