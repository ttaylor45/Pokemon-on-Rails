class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.order(:pokedex_number)

    if params[:search].present?
      @pokemons = @pokemons.where("name ILIKE ?", "%#{params[:search]}%")
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
