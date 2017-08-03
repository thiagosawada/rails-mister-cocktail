# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

document = open(url).read
ingredients = JSON.parse(document)

all_ingredients = []

ingredients["drinks"].each do |ingredient|
  all_ingredients << Ingredient.create!(name: ingredient["strIngredient1"])
end

20.times do
  c = Cocktail.create(name: Faker::StarWars.character)
  rand(3..5).times do
    Dose.create(description: "#{rand(1..15)} ml", ingredient: all_ingredients.sample, cocktail: c)
  end
end
