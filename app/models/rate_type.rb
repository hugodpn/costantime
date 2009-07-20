# == Schema Information
# Schema version: 20090716152445
#
# Table name: rate_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class RateType < ActiveRecord::Base
  has_many :projects
end
