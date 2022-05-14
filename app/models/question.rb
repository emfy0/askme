class Question < ApplicationRecord
  validates :body, { presence: true,
                     length: { maximum: 280 } }
  belongs_to :user
  belongs_to :author, class_name: :User, optional: true

  has_many :hashtag_linkers, dependent: :destroy
  has_many :hashtags, through: :hashtag_linkers

  after_commit :set_hashtags, on: %i[create update]
  after_destroy :delete_unassociated_hashtags

  def set_hashtags
    body_hashtags = get_string_hashtags(body)

    answer_hashtags = get_string_hashtags(answer)

    (body_hashtags + answer_hashtags).uniq.each do |h|
      founded_hashtags = Hashtag.find_by(text: h)

      if founded_hashtags.nil?
        hashtags.create(text: h.downcase)
      else
        hashtag_linkers.create(question_id: id, hashtag_id: founded_hashtags.id)
      end
    end
  end

  def delete_unassociated_hashtags
    Hashtag.left_joins(:hashtag_linkers).where(hashtag_linkers: { hashtag_id: nil }).delete_all
  end

  private

  def get_string_hashtags(str)
    if str.nil?
      []
    else
      str.scan(/#[\wА-я]+/).map(&:strip)
    end
  end
end
