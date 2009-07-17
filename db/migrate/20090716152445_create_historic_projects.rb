class CreateHistoricProjects < ActiveRecord::Migration
  def self.up
    create_table :historic_projects do |t|
      t.integer :project_id
      t.float :income
      t.date :historic_date

      t.timestamps
    end
  end

  def self.down
    drop_table :historic_projects
  end
end
