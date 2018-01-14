class Question < ApplicationRecord

  WORD_START_FIELDS = ['title^10', 'body']
  searchkick word_start: WORD_START_FIELDS

  has_many :answers, dependent: :destroy
  has_many :answer_authors, through: :answers, source: :author
  belongs_to :author, class_name: "User", foreign_key: :user_id

  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true

  delegate :first_name, to: :author, prefix: true

  def search_data
    {
      title: title,
      body: body,
      user_id: user_id,
      created_at: created_at,
    }
  end

  def self.perform_search(params = {})
    search_term = params[:search].present? ? params[:search] : '*'

    search_params = default_search_params(params)
    search_params[:where][:user_id] = params[:user_id] if params[:user_id].present?
    self.search(search_term, search_params)
  end

  def self.autocomplete_search(params={})
    search_options = {
      fields: WORD_START_FIELDS,
      limit: 10,
      misspellings: { below: 5 },
    }
    Question.search(params[:query], search_options)
  end

  def has_author?(user)
    self.author == user
  end

  def fetch_answers(id=nil)
    options = {
      question_id: self.id,
      user_id: id
    }
    Answer.perform_search(options)
  end

  private
  def self.default_search_params(params = {})
    {
      fields: WORD_START_FIELDS,
      page: params[:page],
      per_page: PER_PAGE,
      where: {},
      order: { created_at: {order: "desc" } }
    }
  end
end
