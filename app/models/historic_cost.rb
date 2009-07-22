class HistoricCost < ActiveRecord::Base
  belongs_to :person

  validates_presence_of :cost
  validates_presence_of :historic_date
  validates_uniqueness_of :historic_date, :scope => "person_id"
end
