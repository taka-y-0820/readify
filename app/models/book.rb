class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_image
  
  has_many :readings, dependent: :destroy
  
  validates :title, presence: true
  validates :author, presence: true
  
  # ステータス: reading (読書中), finished (完読), want_to_read (積読)
  enum :status, { want_to_read: 0, reading: 1, finished: 2 }, default: :want_to_read
  
  # 進捗率 (0-100)
  validates :progress, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  
  scope :recent, -> { order(updated_at: :desc) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
end
