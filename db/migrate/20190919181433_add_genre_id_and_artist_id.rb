class AddGenreIdAndArtistId < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :artist_id, :integer
    add_column :artists, :genre_id, :integer
  end
end
