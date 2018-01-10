class Question < ApplicationRecord

  belongs_to :author, class_name: "User", foreign_key: :user_id

  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true

  scope :recent, -> { order("created_at DESC") }
end
