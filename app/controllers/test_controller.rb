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

    sleep 0.5
    
    render :text => response.to_json, :content_type => Mime::TEXT
  end
end