class HistoricProject < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :profit
  validates_presence_of :historic_date
  validates_uniqueness_of :historic_date, :scope => "project_id"
end
