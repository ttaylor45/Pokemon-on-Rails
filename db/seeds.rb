# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "net/http"
require "json"
require "open-uri"

puts "clearing old data..."

Pokemon.delete_all
Type.delete_all
Ability.delete_all
Move.delete_all
PokemonType.delete_all
PokemonAbility.delete_all
PokemonMove.delete_all

puts "Loading Pokemon Data..."

# This is the data source from the github pokemon.json database.

pokedex_url = "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/pokedex.json"
pokedex_data = JSON.parse(URI.open(pokedex_url).read)

pokedex_data.first(151).each do |pokemon_json|
  pokemon_number = pokemon_json["id"]

  api_url = URI("https://pokeapi.co/api/v2/pokemon/#{pokemon_number}")
  response = Net::HTTP.get(api_url)
  api_data = JSON.parse(response)

  # This is the data source from PokeAPI, Im only importing the first 151 pokemon
  pokemon = Pokemon.create!(
    name: api_data["name"].capitalize,
    pokedex_number: api_data["id"],
    height: api_data["height"],
    weight: api_data["weight"],
    base_experience: api_data["base_experience"],
    sprite_url: api_data["sprites"]["front_default"]
  )

  api_data["types"].each do |type_data|
    type = Type.find_or_create_by!(
      name: type_data["type"]["name"].capitalize
      )

      PokemonType.create!(
        pokemon: pokemon,
        type: type
      )
  end

  api_data["abilities"].each do |ability_data|
    ability = Ability.find_or_create_by!(
      name: ability_data["ability"]["name"].capitalize
    )

    PokemonAbility.create!(
      pokemon: pokemon,
      ability: ability
    )
  end

  api_data["moves"].each do |move_data|
    move = Move.find_or_create_by!(
      name: move_data["move"]["name"].capitalize
    )

    PokemonMove.create!(
      pokemon: pokemon,
      move: move
    )
  end

  puts "Creating fake trainer reviews..."
  # Data source 3 which using the faker gem to create fake reviews for each pokemon. Each pokemon will have 4 reviews created by fake trainers.
  Pokemon.all.each do |pokemon|
    4.times do
      Review.create!(
        pokemon: pokemon,
        trainer_name: Faker::Name.name,
        rating: rand(1..5),
        comment: Faker::Games::Pokemon.move
      )
    end
  end

  puts "Imported #{pokemon.name}"
end

puts "Done!"
puts "Pokemon: #{Pokemon.count}"
puts "Types: #{Type.count}"
puts "Abilities: #{Ability.count}"
puts "Moves: #{Move.count}"
puts "Pokemon Types: #{PokemonType.count}"
puts "Pokemon Abilities: #{PokemonAbility.count}"
puts "Pokemon Moves: #{PokemonMove.count}"
puts "Reviews: #{Review.count}"
