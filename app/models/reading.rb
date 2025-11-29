class Reading < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, :book_id, presence: true
  
  # 読書記録に感想、メモ、評価を追加
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
  
  scope :recent, -> { order(created_at: :desc) }
  scope :with_rating, -> { where.not(rating: nil) }
  scope :by_book, ->(book_id) { where(book_id: book_id) if book_id.present? }
end
