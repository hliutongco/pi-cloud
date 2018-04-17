# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "lilruby", email: "lilrubyrox@gmail.com", password_digest: "lilrubyrox", bio: "lil ruby rox", img: "https://cdn-images-1.medium.com/max/1600/1*p0uOGL9JugR5rAQAu8pujA.png")
User.create(name: "lilbooboo", email: "lilbooboo@gmail.com", password_digest: "lilbooboorox", bio: "lil booboo rox", img: "http://berryripe.com/wp-content/uploads/2012/10/band-aid.jpg")
User.create(name: "lildiamond", email: "lildiamond@gmail.com", password_digest: "lildiamondrox", bio: "lil diamond rox", img: "https://assets.ritani.com/assets/education_channel/diamonds/diamond-anatomy-27680883da28fb94afdbd63f43b03f48.png")

Song.create(song_url: "http://testurl.com", code: "this is a test", title: "awesome song", genre: "conscious rap", img: "https://cdn-images-1.medium.com/max/1600/1*p0uOGL9JugR5rAQAu8pujA.png", user_id: 1)
Song.create(song_url: "http://testurl2.com", code: "this is a second test", title: "sick beats", genre: "trap", img: "http://berryripe.com/wp-content/uploads/2012/10/band-aid.jpg", user_id: 2)
Song.create(song_url: "http://testurl3.com", code: "this is a third test", title: "slow jam", genre: "smooth jazz", img: "https://assets.ritani.com/assets/education_channel/diamonds/diamond-anatomy-27680883da28fb94afdbd63f43b03f48.png", user_id: 3)

Playlist.create(name: "Hot Playlist", description: "this s*** is tight", user_id: 1)
SongPlaylist.create(playlist_id: 1, song_id: 1)
