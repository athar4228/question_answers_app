class AnswersController < ApplicationController
  before_action :set_question, only: [:create, :edit, :update, :destroy]
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :verify_author, only: [:edit, :update]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render 'questions/show'
    end
  end

  def edit
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
  end

  private
  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.fetch(:answer).permit(:body)
  end

  def verify_author
    unless @answer.has_author?(current_user)
      redirect_to questions_path, notice: 'You are not allowed to perform this action'
    end
  end

end
