class CreateClassifiers < ActiveRecord::Migration
  def self.up
    create_table :classifiers do |t|
      t.column :name, :string
      t.column :abrev, :string
    end
  end
  
  def self.down
    drop_table :classifiers
  end
end