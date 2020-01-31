class VideosController < ApplicationController
  before_action :require_user_logged_in
  require 'google/apis/youtube_v3'
 
 def show
   @marker = Marker.find(params[:id])
 end
 
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
        video = Video.find_or_initialize_by(read(item))
        @videos << video
      end
    end
  end
  
  def create
    @video = Video.find_or_initialize_by(video_id: params[:video_id])

    unless @video.persisted?
      # @video が保存されていない場合、先に @video を保存する
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = "AIzaSyBygnUHbJ6EfyBuzIoVNBkAFv1QCzImt-4"
      results = youtube.list_searches(part="snippet" ,
                                      type: "video" ,
                                      q: @video.video_id,
                                      max_results: 1 ,)

      results.items.each do |item|
        @video = Video.new(read(item))
        @video.save
      end
    end
    
    redirect_to new_marker_path(id: @video.id)
  end
end