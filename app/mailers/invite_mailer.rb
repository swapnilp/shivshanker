class InviteMailer < ActionMailer::Base
#  default :from => 'SportsBeat.com <support@sportsbeat.com>'

  def invite_message(invite)
    @invite = invite
    @recipient_display_name = invite.name.blank? ? invite.email : invite.name
    mail(:from=>"dummyid116@gmail.com",:to => invite.email, :subject => invite.user.display_name + ' invites you to join SportsBeat.com')
  end
end
