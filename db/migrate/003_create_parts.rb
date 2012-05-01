class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|  
      t.column :work_id, :integer
      t.column :data, :string
    end    
  end
  
  def self.down
    drop_table :parts
  end
end