module Slugifiable
  # Will take in a artist/song/genre name and slugify it.
  def slug
    self.name.gsub(/[^a-zA-Z0-9\-\s+]/,"").gsub(/\s+/, "-").downcase
  end
end