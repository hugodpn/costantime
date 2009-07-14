class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.integer :company_id
      t.integer :rate_type_id
      t.float :rate
      t.integer :duration

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
