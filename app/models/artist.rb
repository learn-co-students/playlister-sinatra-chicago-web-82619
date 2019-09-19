class Artist < ActiveRecord::Base

    has_many :songs
    has_many :genres, through: :songs

    def slug
        name = self.name.downcase
        name = name.split
        name.join("-")
    end

    def self.find_by_slug(slug)
        slug = slug.split("-")
        slug = slug.join(" ")
        Artist.all.find {|a| a.name.downcase == slug}
    end

end