class Move < ApplicationRecord
  has_many :pokemon_moves
  has_many :pokemon, through: :pokemon_moves

  validates :name, presence: true
  validates :name, uniqueness: true
end
