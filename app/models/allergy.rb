class Allergy < ApplicationRecord
  has_many :conditions, dependent: :destroy
  has_many :users, through: :conditions

  validates :name, presence: true, uniqueness: true
end
