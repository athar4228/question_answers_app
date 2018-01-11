module QuestionsHelper

  def can_submit_answer?(question)
    return false unless user_signed_in?
    return false if question.answer_authors.include?(current_user)
    return true
  end
end
