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


  

end
