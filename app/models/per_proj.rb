class PerProj < ActiveRecord::Base
  belongs_to :person
  belongs_to :project
end
