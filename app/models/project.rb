class Project < ActiveRecord::Base
  has_many :person_projects
  has_many :people, :through => :person_projects
  has_many :historic_projects

  belongs_to :company
  belongs_to :rate_type  

  validates_presence_of :name

end
