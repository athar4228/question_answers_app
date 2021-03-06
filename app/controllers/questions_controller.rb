class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search, :autocomplete]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :verify_author, only: [:edit, :update]

  def index
    @questions = Question.perform_search(params)
  end

  def search
    @questions = Question.perform_search(params)
    render 'index'
  end

  def show
    @answers = @question.fetch_answers(current_user&.id)
    @new_answer = @question.answers.build if user_signed_in?
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user
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

  def autocomplete
    @questions = Question.autocomplete_search(params)
    render json: @questions.collect(&:title)
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.fetch(:question).permit(:title, :body)
  end

  def verify_author
    unless @question.has_author?(current_user)
      redirect_to questions_path, notice: 'You are not allowed to perform this action'
    end
  end
end
