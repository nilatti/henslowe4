class Specialization < ActiveRecord::Base
  default_scope { order('title')}
end
