class Question < ApplicationRecord

  has_many :answers, dependent: :destroy
  has_many :answer_authors, through: :answers, source: :author
  belongs_to :author, class_name: "User", foreign_key: :user_id

  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true

  scope :recent, -> { order("created_at DESC") }

  def has_author?(user)
    self.author == user
  end
end
