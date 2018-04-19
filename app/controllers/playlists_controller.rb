class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :destroy, :update, :all_songs, :remove_song]
  before_action :set_user#, only: [:show, :edit, :destroy, :update, :index]

  def index
    @playlists = Playlist.all
  end

  def show
    if logged_in?
      @song_playlist = SongPlaylist.new
      @playlist_comment = PlaylistComment.new
      @comments = PlaylistComment.all
      if @comments
        @comments = PlaylistComment.all.select {|c| c.playlist_id == @playlist.id}
      end
    end
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user_id = current_user.id
    if @playlist.save

      redirect_to user_playlist_path(@user, @playlist)
    else
      flash[:errors] = @playlist.errors.full_messages
      redirect_to new_user_playlist_path
    end
  end

  def remove_song
    # byebug
    @song_playlist = SongPlaylist.find_by(song_id: params[:song_id], playlist_id: params[:id])
    @song_playlist.destroy
    redirect_to user_playlist_path(@user, @playlist)
  end

  def edit
  end

  def update
    @playlist.update(playlist_params)
    if @playlist.valid?
      redirect_to user_playlist_path(@playlist)
    else
      flash[:errors] = @playlist.errors.full_messages
      redirect_to edit_user_playlist_path(@user, @playlist)
    end
  end

  def destroy
    @playlist.destroy
    redirect_to user_playlists_path
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :mood, :description)
  end

  def set_user
    @user = User.find(params[:user_id])
  end


end
