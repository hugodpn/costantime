class Project < ActiveRecord::Base
  has_many :per_projs
  has_many :people, :through => :per_projs

  belongs_to :company
  belongs_to :rate_type
end
