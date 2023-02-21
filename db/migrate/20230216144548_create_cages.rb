class CreateCages < ActiveRecord::Migration[7.0]
  def change
    create_table :cages do |t|
      t.string :name
      t.integer :max_capacity
      t.integer :power_status
      t.integer :dinosaurs_count, default: 0

      t.timestamps
    end
  end
end
