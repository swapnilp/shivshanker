require "commentable"

class CalendarEvent < ActiveRecord::Base
  include Commentable

  belongs_to :creator, :class_name => "User"
  belongs_to :owner, :polymorphic => true
  has_many :calendar_event_invitations, :dependent => :destroy
  has_many :invited_users, :through => :calendar_event_invitations, :source => :recipient

  validates :creator, :presence => true
  validates :owner, :presence => true
  validates :datetime, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
end