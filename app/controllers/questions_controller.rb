class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_url, notice: 'Question was successfully destroyed.'
    else
      redirect_to questions_url, notice: 'Question is not destroyed.'
    end
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.fetch(:question).permit(:title, :body)
  end
end
