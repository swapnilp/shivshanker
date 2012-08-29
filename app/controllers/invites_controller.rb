#require 'signed_request'
#require 'rexml/document'

class InvitesController < ApplicationController
  before_filter :authenticate_user!

  def index
   
  end

  def add_manual_invites

    @user = current_user;
    @invites = []
    @invites_submitted = params[:invites] || []
    @invites_submitted = @invites_submitted.reject {|i| i[:email].blank? || i[:name].blank?}

    @invites_submitted.each do |i|
      invite = Invite.new
      invite.user = @user
      invite.name = i[:name];
      invite.email = i[:email];

      if invite.save
	
        @invites << invite
	else 
	puts invite.errors.to_json
      end
    end

    @skipped = @invites_submitted.length - @invites.length

    @invites.each do |i|
      i.send_invitation
    end

    if @invites_submitted.length > 0
      #if !UserScore.done_before? @user, 'first_invite'
        #UserScore.add_score_immediately @user, 'first_invite'
      #end
    end
    respond_to do |formate|
	formate.json {render :json=>{:data=>"success"}}
    end

  end

  def check_invited
    
  end

  def get_current_user
    respond_to do |format|
      format.json {render :json => current_user}
    end
  end
  
end
