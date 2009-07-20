# == Schema Information
# Schema version: 20090716152445
#
# Table name: companies
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Company < ActiveRecord::Base
  has_many :projects
end
