class Person < ActiveRecord::Base
  has_many :per_projs
  has_many :projects, :through => :per_projs
end
