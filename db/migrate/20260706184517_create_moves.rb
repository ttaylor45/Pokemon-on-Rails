class CreateMoves < ActiveRecord::Migration[8.1]
  def change
    create_table :moves do |t|
      t.string :name

      t.timestamps
    end
  end
end
