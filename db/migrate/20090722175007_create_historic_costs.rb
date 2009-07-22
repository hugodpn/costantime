class CreateHistoricCosts < ActiveRecord::Migration
  def self.up
    create_table :historic_costs do |t|
      t.integer :person_id
      t.float :cost
      t.date :historic_date

      t.timestamps
    end
  end

  def self.down
    drop_table :historic_costs
  end
end
