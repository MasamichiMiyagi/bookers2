class Book < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  belongs_to :user

  has_one_attached :profile_image


end
