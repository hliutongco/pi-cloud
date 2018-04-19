class SongCommentsController < ApplicationController

  def new
    @song_comment = SongComment.new
  end
  def create
    @comment = SongComment.create(get_params)
    redirect_to user_song_path(@comment.user, @comment.song)
  end
  def destroy
    comment = SongComment.find(params[:id])
    comment.destroy
    song = Song.find(params[:song_id])
    user = User.find(params[:user_id])
    redirect_to user_song_path(user, song)
  end

  private

  def get_params
    params.require(:song_comment).permit(:user_id, :song_id, :content)
  end
end
