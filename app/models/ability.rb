class Ability < ApplicationRecord
  has_many :pokemon_abilities
  has_many :pokemon, through: :pokemon_abilities
end
