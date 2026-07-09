class PokemonType < ApplicationRecord
  belongs_to :pokemon
  belongs_to :type

  validates :pokemon_id, presence: true
  validates :type_id, presence: true
end
