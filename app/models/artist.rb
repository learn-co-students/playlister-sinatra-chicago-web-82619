require_relative "./concerns/slugifiable.rb"
class Artist < ActiveRecord::Base
include Slugifiable
  has_many :songs
  has_many :genres, through: :songs

  def self.find_by_slug(slug)
    self.all.find {|artist| artist.slug == slug}
  end
end
  