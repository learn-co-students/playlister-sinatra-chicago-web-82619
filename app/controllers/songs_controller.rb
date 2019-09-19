require 'rack-flash'
class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash


  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @genres = @song.genres
    @artist = @song.artist
    erb :'songs/show'

  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = Genre.all
    erb :'songs/edit'
  end

  post '/songs' do

    @song = Song.create(params[:song])

    @song.artist = Artist.find_or_create_by(name: params[:artist])
    @song.genres << Genre.find_or_create_by(name: params[:genre])
    # params[:genre].each {|genre_name| song.genres << Genres.find_or_create_by(name: genre_name)}
    @song.save

    flash[:message] = "Successfully created song."

    redirect to("/songs/#{@song.slug}")
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist])
    @song.genres << Genre.find_or_create_by(name: params[:genre])

    flash[:message] = "Successfully updated song."

    redirect to("/songs/#{@song.slug}")
  end

end
