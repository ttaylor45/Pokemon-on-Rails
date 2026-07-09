class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.string :trainer_name
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
