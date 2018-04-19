class PlaylistCommentsController < ApplicationController
  def new
    @playlist_comment = PlaylistComment.new
  end
  def create
    @comment = PlaylistComment.create(get_params)
    redirect_to user_playlist_path(@comment.user, @comment.playlist)
  end
  def destroy
    comment = PlaylistComment.find(params[:id])
    comment.destroy
    playlist = Playlist.find(params[:playlist_id])
    user = User.find(params[:user_id])
    redirect_to user_playlist_path(user, playlist)
  end

  private

  def get_params
    params.require(:playlist_comment).permit(:user_id, :playlist_id, :content)
  end
end
