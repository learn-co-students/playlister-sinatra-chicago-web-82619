class Song < ActiveRecord::Base

    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    def slug
        name = self.name.downcase
        name = name.split
        name.join("-")
    end

    def self.find_by_slug(slug)
        slug = slug.split("-")
        slug = slug.join(" ")
        Song.all.find {|a| a.name.downcase == slug}
    end

end