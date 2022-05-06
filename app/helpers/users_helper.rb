module UsersHelper
  def add_at(str)
    "@#{str}"
  end

  def user_link(author)
    if author.present?
      link_to add_at(author.nickname), user_path(author), class: 'nickname'
    else
      content_tag(:span, '@аноним', class: 'text-underline')
    end
  end
end
