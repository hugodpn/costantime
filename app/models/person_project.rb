class PersonProject < ActiveRecord::Base
  belongs_to :person
  belongs_to :project

  validates_presence_of :percentage
  validates_numericality_of :percentage, :greater_than_or_equal_to => 0
  validates_numericality_of :percentage, :less_than_or_equal_to => 100


  

end
