class Genre < ActiveRecord::Base

    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def slug
        name = self.name.downcase
        name = name.split
        name.join("-")
    end

    def self.find_by_slug(slug)
        slug = slug.split("-")
        slug = slug.join(" ")
        Genre.all.find {|a| a.name.downcase == slug}
    end

end