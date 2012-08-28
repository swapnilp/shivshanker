class Invite < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :email, :scope => [:user_id], :on => :create
  # validate :not_for_existing_user, :on => :create

  # def not_for_existing_user
  #   unless User.where('email = ?', email).empty?
  #     errors.add(:email, 'belongs to an existing sportsbeat.com user');
  #   end
  # end

  def self.find_or_create(user_id, name, email)
    invite = Invite.where('email = ? AND user_id = ?', email, user_id).first

    if invite
      return invite
    else
      return Invite.new({:user_id => user_id, :name => name, :email => email})
    end
  end

  def send_invitation
    InviteMailer.invite_message(self).deliver
  end
end
