require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

Tmdb::Api.key('abd0a274114221f5307debf86cf3e0fe')
response = Tmdb::Movie.popular
movies = response.results.take(10) # Prend les 10 premiers films

movies.each do |movie|
  title = movie.title
  poster_path = movie.poster_path
  article = Article.new(title: title)

  # Open image in binary mode
  image_url = "https://image.tmdb.org/t/p/original#{poster_path}"
  image = URI.open(image_url)

  # Check if the image is not nil and only then attach it
  if image.present?
    article.photo.attach(io: image, filename: "#{title.parameterize}.jpg", content_type: 'image/jpg')
    article.save!
  end
end


puts 'Seed completed successfully!'
