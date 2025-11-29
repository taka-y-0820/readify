class CreateReadings < ActiveRecord::Migration[8.0]
  def change
    create_table :readings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.text :note
      t.text :review
      t.integer :rating
      t.date :started_at
      t.date :finished_at
      
      t.timestamps
    end
    
    add_index :readings, [:user_id, :book_id]
    add_index :readings, :rating
  end
end
