class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :destroy, :update, :all_songs, :remove_song, :add_song]
  before_action :set_user#, only: [:show, :edit, :destroy, :update, :index]

  def index
    @playlists = @user.playlists
  end

  def show
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist.new(playlist_params)
    if @playlist.save
      redirect_to playlist(@playlist)
    else
      flash[:errors] = @playlist.errors.full_messages
      redirect_to new_playlist_path
    end
  end

  def all_songs
    @playlist.songs
  end

  def remove_song(song_id)
    song = Song.find(song_id)
    if song
      @playlist.delete(song)
    end
  end

  def add_song(song_id)
    song = Song.find(song_id)
    @playlist << song
  end

  def edit
  end

  def update
    @playlist.update(playlist_params)
    if @playlist.valid?
      redirect_to playlist(@playlist)
    else
      flash[:errors] = @playlist.errors.full_messages
      redirect_to edit_playlist_path(@user, @playlist)
    end
  end

  def destroy
    @playlist.destroy
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :description, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # create_table "playlists", force: :cascade do |t|
  #   t.integer "user_id"
  #   t.string "name"
  #   t.string "description"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end
  #
  # create_table "song_playlists", force: :cascade do |t|
  #   t.integer "playlist_id"
  #   t.integer "song_id"
  # end
  #
  # create_table "songs", force: :cascade do |t|
  #   t.string "song_url"
  #   t.string "code"
  #   t.string "title"
  #   t.string "genre"
  #   t.string "img"
  #   t.integer "user_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end
  #
  # create_table "users", force: :cascade do |t|
  #   t.string "name"
  #   t.string "email"
  #   t.string "password"
  #   t.string "bio"
  #   t.string "img"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

end
