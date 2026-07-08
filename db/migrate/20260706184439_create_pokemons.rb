class CreatePokemons < ActiveRecord::Migration[8.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :pokedex_number
      t.integer :height
      t.integer :weight
      t.integer :base_experience
      t.string :sprite_url

      t.timestamps
    end
  end
end
