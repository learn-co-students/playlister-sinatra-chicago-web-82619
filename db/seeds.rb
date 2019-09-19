# Add seed data here. Seed your database with `rake db:seed`
Song.all.destroy_all
Artist.all.destroy_all
Genre.all.destroy_all
LibraryParser.parse
