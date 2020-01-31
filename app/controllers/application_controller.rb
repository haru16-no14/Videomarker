class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def read(item)
    id = item.id
    snippet = item.snippet    
    video_id = id.video_id
    video_title = snippet.title
    channel_title = snippet.channel_title 
    thumbnail_url= snippet.thumbnails.medium.url
    
    {
      video_id: video_id,
      video_title: video_title,
      channel_title: channel_title, 
      thumbnail_url: thumbnail_url,
    }
  end
end
