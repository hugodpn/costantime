class Project < ActiveRecord::Base
  belongs_to :company
  belongs_to :rate_type
end
