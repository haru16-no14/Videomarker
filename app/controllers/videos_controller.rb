class VideosController < ApplicationController
  before_action :require_user_logged_in
  require 'google/apis/youtube_v3'
 
  def new
    @videos = []
    
    @keyword = params[:q]
    if  @keyword.present?
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = "AIzaSyBygnUHbJ6EfyBuzIoVNBkAFv1QCzImt-4"
      results = youtube.list_searches(part="snippet" , 
                                    type: "video" ,
                                    q: @keyword , 
                                    max_results: 12 , 
                                    order: :date , 
      )
      
      results.items.each do |item|
        video = Video.new(read(item))
        @videos << video
      end
    end
  end
  
  private
  
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