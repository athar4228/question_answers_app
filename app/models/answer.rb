class Answer < ApplicationRecord

  belongs_to :author, class_name: "User", foreign_key: :user_id
  belongs_to :question

  validates :body, presence: true
  validates :question_id, uniqueness: { scope: :user_id }

  delegate :first_name, to: :author, prefix: true

  def has_author?(user)
    self.author == user
  end
end
