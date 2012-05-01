class CreateClassifications < ActiveRecord::Migration
  def self.up
    create_table :classifications do |t|
      t.column :work_id, :integer
      t.column :classifier_id, :integer
    end
  end
end