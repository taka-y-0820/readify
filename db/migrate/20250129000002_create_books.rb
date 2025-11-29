class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :author, null: false
      t.text :description
      t.string :isbn
      t.string :publisher
      t.date :published_date
      t.integer :page_count
      t.string :cover_url
      t.string :google_books_id
      t.integer :status, default: 0, null: false
      t.integer :progress, default: 0
      
      t.timestamps
    end
    
    add_index :books, [:user_id, :google_books_id], unique: true, where: "google_books_id IS NOT NULL"
    add_index :books, :status
  end
end
