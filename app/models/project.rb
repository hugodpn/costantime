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

  def person_filter from, to
    @per_pro = []
    self.person_projects.collect { |pp|
      @per_pro << pp if pp.date_worked > from && pp.date_worked < to
    }
    @per_pro
  end


end
