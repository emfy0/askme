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
      founded_hashtag = Hashtag.find_by(text: h)

      if founded_hashtag.nil?
        hashtags.create(text: h)
      elsif founded_hashtag.questions.include?(self) == false
        hashtag_linkers.create(hashtag_id: founded_hashtag.id)
      end
    end
  end

  def delete_unassociated_hashtags
    Hashtag.left_joins(:hashtag_linkers).where(hashtag_linkers: { question_id: nil }).delete_all
  end

  private

  def get_string_hashtags(str)
    if str.nil?
      []
    else
      str.scan(/#[\wА-я]+/).map(&:strip).map(&:downcase)
    end
  end
end
