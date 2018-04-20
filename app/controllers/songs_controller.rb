class SongsController < ApplicationController
  before_action :set_songs, only: [:show, :edit, :update, :destroy, :add_to_playlist]
  before_action :set_user

  def index
    if params[:search]
     @songs = Song.select{|s| s.genre.downcase.strip == params[:search].downcase.strip}
    else
     @songs = Song.all
    end
    @genres = Song.genres
  end

  def show
    if logged_in?
      @playlists = @user.playlists
      @song_playlist = SongPlaylist.new
      @song_comment = SongComment.new
      @comments = SongComment.all
      if @comments
        @comments = SongComment.all.select {|c| c.song_id == @song.id}
      end
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

    p_id = @playlist.to_i
    s_id = params[:id].to_i
    already_added = SongPlaylist.all.select do |sp|
      sp.playlist_id == p_id && sp.song_id == s_id
    end


    if already_added.empty?
      @playlist_song = SongPlaylist.new(playlist_song_params)
      @playlist_song.song_id = params[:id]
      @playlist_song.save
      redirect_to user_playlist_path(@user, @playlist)
    else
      flash[:add_to_playlist_errors] = "This song is already on your playlist."
      redirect_to user_song_path(@user, @song)
    end
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
      redirect_to new_user_song_path(@user, @song)
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
