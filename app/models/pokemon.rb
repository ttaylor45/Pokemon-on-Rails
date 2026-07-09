class Pokemon < ApplicationRecord
  has_many :pokemon_types
  has_many :types, through: :pokemon_types

  has_many :pokemon_abilities
  has_many :abilities, through: :pokemon_abilities

  has_many :pokemon_moves
  has_many :moves, through: :pokemon_moves

  has_many :reviews, dependent: :destroy
end
