class PokemonAbility < ApplicationRecord
  belongs_to :pokemon
  belongs_to :ability

  validates :pokemon_id, presence: true
  validates :ability_id, presence: true
end
