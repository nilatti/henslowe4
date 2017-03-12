class RehearsalCall < ActiveRecord::Base
  belongs_to :rehearsal
  belongs_to :user
end
