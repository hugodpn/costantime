# == Schema Information
# Schema version: 20090716152445
#
# Table name: people
#
#  id            :integer         not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  salary        :float
#  working_hours :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Person < ActiveRecord::Base
  has_many :person_projects, :order => "date_worked desc"
  has_many :projects, :through => :person_projects
  has_many :historic_costs

  def cost_by_percentage percentage
    self.salary * percentage / 100
  end

  def project_filter from, to
    @per_pro = []
    self.person_projects.collect { |pp|
      @per_pro << pp if pp.date_worked > from && pp.date_worked < to
    }
    @per_pro
  end

end
