class CreateDinosaurs < ActiveRecord::Migration[7.0]
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.integer :species
      t.integer :diet
      t.references :cage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
