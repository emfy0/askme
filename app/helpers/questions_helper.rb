module QuestionsHelper
  def hide_button(question)
    if question.hidden?
      {
        fa_icon_class: 'eye',
        title: 'Показать вопрос'
      }
    else
      {
        fa_icon_class: 'eye-slash',
        title: 'Скрыть вопрос'
      }
    end
  end

  def availiable_questions(questions)
    questions.select { |question| !question.hidden? || question.user == current_user }
  end
end
