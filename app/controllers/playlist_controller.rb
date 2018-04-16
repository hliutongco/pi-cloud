class PlaylistController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :description, :user_id)
  end



    # create_table "playlists", force: :cascade do |t|
    #   t.integer "user_id"
    #   t.string "name"
    #   t.string "description"
    #   t.datetime "created_at", null: false
    #   t.datetime "updated_at", null: false
    # end

    # create_table "songs", force: :cascade do |t|
    #   t.string "song_url"
    #   t.string "code"
    #   t.string "title"
    #   t.string "genre"
    #   t.string "img"
    #   t.integer "user_id"
    #   t.integer "playlist_id"
    #   t.datetime "created_at", null: false
    #   t.datetime "updated_at", null: false
    # end
    
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
