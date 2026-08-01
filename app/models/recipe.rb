class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validates :title, presence: true
  validates :ingredients, presence: true
  validates :instructions, presence: true
end
