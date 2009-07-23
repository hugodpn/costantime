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

  def cost_by_percentage percentage, from, to
    cost_between(from, to) * percentage / 100
  end

  def project_filter from, to
    @per_pro = []
    self.person_projects.collect { |pp|
      @per_pro << pp if pp.date_worked > from && pp.date_worked < to
    }
    @per_pro
  end

  def cost_between(from, to)
    historic_cost = HistoricCost.find(:first, :conditions => ["person_id = ? and historic_date > ? and historic_date < ?", self.id, from, to])
    if historic_cost
      historic_cost.cost
    else
      0
    end
  end

  def set_cost(cost, date)   
    @requested_date = Date.civil(date[0..3].to_i, date[5..6].to_i, 1)
    @from = @requested_date - 1
    @to =  @requested_date >> 1
    
    historic_cost = HistoricCost.find(:first, :conditions => ["person_id = ? and historic_date > ? and historic_date < ?", self.id, @from, @to])
    if historic_cost
      historic_cost.cost = cost
      historic_cost.save
    else
      0
    end
  end


  def self.total_cost(from, to)
    @total = 0
    Person.all.each do |person|
      @total += person.cost_between(from, to)
    end
    @total
  end

end
