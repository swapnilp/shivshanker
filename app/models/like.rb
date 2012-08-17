class Like < ActiveRecord::Base
  belongs_to :likable, :polymorphic => true
  belongs_to :user
  
  validate :user_id, :uniqueness => {:scope => [:likable_id, :likable_type]}
  validate :value, :exclusion => { :in => [0] }
end
