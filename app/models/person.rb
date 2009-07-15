class Person < ActiveRecord::Base
  has_many :person_projects, :order => "date_worked desc"
  has_many :projects, :through => :person_projects
end
