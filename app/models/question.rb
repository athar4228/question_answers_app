class Question < ApplicationRecord

  belongs_to :user

  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true

  scope :recent, -> { order("created_at DESC") }
end
