class CalendarEventInvitation < ActiveRecord::Base
  belongs_to :calendar_event
  belongs_to :creator, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  validate :calendar_event, :presence => true
  validate :creator, :presence => true
  validate :recipient, :prence => true

  def accepted?
    self.accepted == true
  end

  def declined?
    self.accepted == false
  end

  def undecided?
    self.accepted == nil
  end
end