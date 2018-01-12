class Question < ApplicationRecord

  WORD_START_FIELDS = ['title^10', 'body']
  searchkick word_start: WORD_START_FIELDS

  PER_PAGE = 20
  has_many :answers, dependent: :destroy
  has_many :answer_authors, through: :answers, source: :author
  belongs_to :author, class_name: "User", foreign_key: :user_id

  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true

  scope :recent, -> { order("created_at DESC") }

  def search_data
    {
      title: title,
      body: body,
      user_id: user_id
    }
  end

  def self.perform_search(params = {})
    search_term = params[:search].present? ? params[:search] : '*'

    search_params = default_search_params(params)
    search_params[:where][:user_id] = params[:user_id] if params[:user_id].present?

    self.search(search_term, search_params)
  end

  def self.default_search_params(params = {})
    {
      fields: WORD_START_FIELDS, match: :word_start,
      page: params[:page],
      per_page: PER_PAGE
    }
  end

  def has_author?(user)
    self.author == user
  end
end
