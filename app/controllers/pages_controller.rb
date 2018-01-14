class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:home]

  def home
    @questions = Question.perform_search
  end
end
