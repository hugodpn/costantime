class CreatePersonProjects < ActiveRecord::Migration
  def self.up
    create_table :person_projects, :id => false do |t|
      t.integer :person_id
      t.integer :project_id
      t.integer :percentage

      t.timestamps
    end
  end

  def self.down
    drop_table :person_projects
  end
end
