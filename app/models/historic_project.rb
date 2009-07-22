# == Schema Information
# Schema version: 20090716152445
#
# Table name: historic_projects
#
#  id            :integer         not null, primary key
#  project_id    :integer
#  income        :float
#  historic_date :date
#  created_at    :datetime
#  updated_at    :datetime
#

class HistoricProject < ActiveRecord::Base

  belongs_to :project

  validates_presence_of :income
  validates_presence_of :historic_date
  validates_uniqueness_of :historic_date, :scope => "project_id"


  def profit_between(from, to)
    @sum = 0
    self.project.person_filter(from, to).each do |pp|
      @sum += pp.person.cost_by_percentage(pp.percentage)
    end

    income - @sum
  end


end
