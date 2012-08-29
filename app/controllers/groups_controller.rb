class GroupsController < ApplicationController
  before_filter :authenticate_user!

#  respond_to :json
  
  def index
    groups = Group.where(:users_id => current_user.id)
    respond_to do |format|
      format.json {render :json => groups}
    end
    #respond_with groups
  end
  
  def create
    Group.transaction do
      group = Group.new
      group.name = params[:name]
      group.users_id = current_user.id
      group.save!
    end
    head :ok
  end
  
end
