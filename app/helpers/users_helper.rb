module UsersHelper
  def add_at(str)
    "@#{str}"
  end

  def author_link(author)
    if author.present?
      link_to add_at(author.nickname), user_path(author), class: 'nickname mr-sm'
    else
      content_tag(:span, '@аноним', class: 'mr-sm text-underline')
    end
  end
end
