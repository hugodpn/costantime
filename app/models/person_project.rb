# == Schema Information
# Schema version: 20090716152445
#
# Table name: person_projects
#
#  id          :integer         not null, primary key
#  person_id   :integer
#  project_id  :integer
#  percentage  :integer
#  date_worked :date
#  created_at  :datetime
#  updated_at  :datetime
#

class PersonProject < ActiveRecord::Base
  belongs_to :person
  belongs_to :project

  validates_presence_of :percentage
  validates_numericality_of :percentage, :greater_than_or_equal_to => 0
  validates_numericality_of :percentage, :less_than_or_equal_to => 100


  def self.percentage_between(from, to, person_id, project_id)
    person_project = PersonProject.first :conditions => ["project_id = ? and person_id = ? and date_worked > ? and date_worked < ?", project_id, person_id, from, to]
    if person_project
      person_project.percentage
    else
      0
    end
  end

  def self.set_person_project(person_id, project_id, percentage, date)
    @requested_date = Date.civil(date[0..3].to_i, date[5..6].to_i, 1)
    @from = @requested_date - 1
    @to =  @requested_date >> 1

    person_project = PersonProject.find(:first, :conditions => ["project_id = ? and person_id = ? and date_worked > ? and date_worked < ?", project_id, person_id, @from, @to] )

    if person_project
      person_project.percentage = percentage
      person_project.save
    else
      PersonProject.create(:project_id => project_id, :person_id => person_id, :date_worked => date, :percentage => percentage)
    end

  end

end
