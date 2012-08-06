class TestController < ApplicationController
  before_filter :authenticate_user!

  def upload
  end

  def receive_upload
    file = params[:file]
    response = [
      {
        name: file.original_filename,
      }
    ]

    picture = Picture.new
    picture.file = params[:file]
    picture.owner = current_user
    picture.gallery = current_user.galleries.where(:name => "My Pictures").first
    picture.save!
    
    render :text => response.to_json, :content_type => Mime::TEXT
  end
end