class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.column :title, :string, :null => false
      t.column :composer_id, :integer, :null => false
      t.column :source, :string
      t.column :url, :string
 
    end
  end

  def self.down
    drop_table :users
  end
end