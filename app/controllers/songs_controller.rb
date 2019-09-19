require 'rack-flash'
class SongsController < ApplicationController
    use Rack::Flash
    get "/songs/?" do
        @songs = Song.all
        erb :"songs/index"
    end

    post '/songs/?' do
        @song = Song.create(name: params["Name"])
        @artist = Artist.find_or_create_by(name: params["Artist Name"])
        @song.artist_id = @artist.id
        params[:genres].each do |genre_id|
            @song.genres << Genre.find(genre_id)
        end
        @song.save
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end
    
    get "/songs/new/?" do
        @artists = Artist.all
        @genre = Genre.all
        erb :"songs/new"
    end

    get "/songs/:slug/?" do
        @song = Song.find_by_slug(params[:slug])
        @artist = Artist.find(@song.artist_id)
        erb :"songs/show"
    end

    get "/songs/:slug/edit/?" do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end

    patch "/songs/:slug/?" do
        @song = Song.find_or_create_by(name: params[:song][:name])
        @artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.artist_id = @artist.id
        @song.genres.clear
        params[:genres].each do |genre_id|
            @song.genres << Genre.find(genre_id)
        end
        @song.save
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end
end