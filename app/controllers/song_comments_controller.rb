class SongCommentsController < ApplicationController

  def new
    @song_comment = SongComment.new
  end
  def create
    @comment = SongComment.create(get_params)
    redirect_to user_song_path(@comment.user, @comment.song)
  end

  private

  def get_params
    params.require(:song_comment).permit(:user_id, :song_id, :content)
  end
end
