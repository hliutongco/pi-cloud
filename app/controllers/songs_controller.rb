class SongsController < ApplicationController
  before_action :set_songs, only: [:show, :edit, :update, :destroy, :add_to_playlist]

  def index
    @songs = Song.all
  end

  def show
    @song_playlist = SongPlaylist.new
    if session[:user_id]
      @user = User.find(session[:user_id])
      @playlists = @user.playlists
    end
  end

  def edit
  end

  def update
    @song.update(song_params)
    if @song.valid?
      redirect_to @song
    else
      flash[:errors] = @song.errors.full_messages
      redirect_to edit_song_path(@song)
    end
  end

  def add_to_playlist(user_id, playlist_id)
  end

  def new
    @song = Song.new
    @song.user_id = params[:user_id]
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to @song
    else
      flash[:errors] = @song.errors.full_messages
      redirect_to new_song_path
    end
  end

  def destroy
    @song.destroy
  end

  private

  def set_songs
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:url, :code, :title, :genre, :avatar, :user_id)
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
