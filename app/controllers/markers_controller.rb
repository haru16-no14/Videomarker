class MarkersController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def show
    @marker = Marker.find(params[:id])
  end
  
  def new
    @video = Video.find_by(id: params[:id])
    @marker = Marker.new
  end
   
  def create
    @video = Video.find_by(video_id: params[:video_id])
    @marker = Marker.new(video: @video,time: params[:time],content: params[:content])
    @marker.user_id = current_user.id
    if @marker.save
      flash[:success] = 'しおりを保存しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'しおりを保存できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @marker.destroy
    flash[:success] = 'しおりを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
 
  def correct_user
    @marker = current_user.markers.find_by(id: params[:id])
    unless @marker
      redirect_to root_url
    end
  end
end