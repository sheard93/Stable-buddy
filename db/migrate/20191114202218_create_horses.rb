class CreateHorses < ActiveRecord::Migration[5.2]
  def change
    create_table :horses do |t|
      t.string :name
      t.string :owner
      t.integer :age
      t.string :breed
      t.timestamps
    end
  end
end
