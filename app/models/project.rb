# == Schema Information
# Schema version: 20090716152445
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base
  has_many :person_projects
  has_many :people, :through => :person_projects
  has_many :historic_projects

  belongs_to :company
  belongs_to :rate_type  

  validates_presence_of :name

  def person_filter(from, to)
    @per_pro = []
    self.person_projects.collect { |pp|
      @per_pro << pp if pp.date_worked > from && pp.date_worked < to
    }
    @per_pro
  end
  #TODO: should change the name by person_project_filter
  alias_method :person_project_filter, :person_filter

  def income_between(from, to)
    historic_project = HistoricProject.find(:first, :conditions => ["project_id = ? and historic_date > ? and historic_date < ?", self.id, from, to])
    if historic_project
      historic_project.income
    else
      0
    end
  end


  def profit_between(from, to)
    
    income = income_between(from, to)

    @cost = 0
    
    person_project_filter(from, to).each do |pp|
      @cost += pp.person.cost_by_percentage(pp.percentage, from, to)
    end

    income - @cost
  end

end
