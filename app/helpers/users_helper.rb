module UsersHelper
  def add_at(str)
    "@#{str}"
  end

  def get_nickname_by_id(id)
    anonim = content_tag(:span, '@аноним', class: 'mr-sm text-underline')
    return anonim if id.nil?

    user = User.find(id)
    if user.present?
      link_to add_at(user.nickname), user_path(user), class: 'nickname mr-sm'
    else
      anonim
    end
  end
end
