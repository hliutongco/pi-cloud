class SongsController < ApplicationController
  before_action :set_songs, only: [:show, :edit, :update, :destroy, :add_to_playlist]
  before_action :set_user

  def index
    @songs = Song.all
  end

  def show
    # @song_playlist = SongPlaylist.new
    if logged_in?
      @user = current_user
      @playlists = @user.playlists
      @song_playlist = SongPlaylist.new
    end
  end

  def edit
  end

  def update
    @song.update(song_params)
    if @song.valid?
      redirect_to [@user, @song]
    else
      flash[:errors] = @song.errors.full_messages
      redirect_to edit_user_song_path(@user, @song)
    end
  end

  def add_to_playlist
    @playlist = params[:song_playlist][:playlist_id]
    @playlist_song = SongPlaylist.new(playlist_song_params)
    @playlist_song.song_id = params[:id]
    @playlist_song.save
    redirect_to user_playlist_path(@user, @playlist)
  end

  def new
    @song = Song.new
    @song.user_id = params[:user_id]
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to user_song_path(@user, @song)
    else
      flash[:errors] = @song.errors.full_messages
      redirect_to new_user_song_path
    end
  end

  def destroy
    @song.destroy
    redirect_to user_songs_path
  end

  private

  def set_songs
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:url, :code, :title, :genre, :avatar, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def playlist_song_params
    params.require(:song_playlist).permit(:playlist_id)
  end


end
