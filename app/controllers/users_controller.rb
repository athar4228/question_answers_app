class UsersController < ApplicationController

  before_action :set_search_params, only: [:my_answers, :my_questions]

  def my_answers
    @answers = Answer.perform_search(@options)
  end

  def my_questions
    @questions = Question.perform_search(@options)
  end

  private
  def set_search_params
    @options = { author_id: current_user.id, page: params[:page] }
  end

end
