class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:home]

  def home
    @questions = Question.recent.first(10)
  end
end
