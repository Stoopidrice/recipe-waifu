class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :recipes
  has_many :conditions, dependent: :destroy
  has_many :allergies, through: :conditions
  has_many :chats

  validates :password, length: { minimum: 6 }, allow_nil: true
end
