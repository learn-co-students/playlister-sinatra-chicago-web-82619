require 'rack-flash'
class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end

  post '/songs' do
    @artist = Artist.find_or_create_by(name: params[:artist_name])
    @song = Song.find_or_create_by(name: params[:song_name], artist: @artist)
    params[:genres].each do |genre_id| 
      genre = Genre.find_by(id: genre_id)
      SongGenre.find_or_create_by(genre_id: genre_id, song_id: @song.id)
    end
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end

  get '/songs/:slug' do 
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  get '/songs/:slug/edit' do
    @genres = Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/edit"
  end
 
  patch '/songs/:slug' do #edit action
    @song = Song.find_by_slug(params[:slug])
    @song.artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.genres.each {|genre| SongGenre.find_by(song_id: @song.id, genre_id: genre.id).destroy}
    params[:genres].each do |genre_id| 
      genre = Genre.find_by(id: genre_id)
      SongGenre.create(genre_id: genre_id, song_id: @song.id)
    end
    @song.save
    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end
  
end

 
