class Answer < ApplicationRecord

  WORD_START_FIELDS = ['body']
  searchkick word_start: WORD_START_FIELDS

  belongs_to :author, class_name: "User", foreign_key: :user_id
  belongs_to :question

  validates :body, presence: true
  validates :question_id, uniqueness: { scope: :user_id }

  delegate :first_name, to: :author, prefix: true

  def search_data
    {
      body: body,
      user_id: user_id,
      created_at: created_at,
      question_id: question_id,
    }
  end

  def self.perform_search(params = {})
    search_term = params[:search].present? ? params[:search] : '*'

    search_params = default_search_params(params)
    search_params[:where][:question_id] = params[:question_id] if params[:question_id].present?
    search_params[:boost_where][:user_id] =  { value: params[:user_id], factor:100 }  if params[:user_id].present?
    search_params[:where][:user_id] = params[:author_id] if params[:author_id].present?

    self.search(search_term, search_params)
  end

  def has_author?(user)
    self.author == user
  end

  private
  def self.default_search_params(params = {})
    {
      fields: WORD_START_FIELDS,
      page: params[:page],
      per_page: PER_PAGE,
      where: {},
      boost_where: {},
      order: {_score: :desc},
      includes:  :question
    }
  end
end
