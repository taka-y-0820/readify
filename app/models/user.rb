class User < ApplicationRecord
  has_secure_password
  
  has_many :books, dependent: :destroy
  has_many :readings, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  
  normalizes :email, with: -> email { email.strip.downcase }
end
