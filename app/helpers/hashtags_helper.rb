module HashtagsHelper
  def links_for_hashtags(hashtags)
    links =
      hashtags.map { |h| link_to "##{h.text}", hashtag_path(h), class: 'text-nounderline' }.join(', ')

    simple_format(links, {}, wrapper_tag: :span)
  end
end
