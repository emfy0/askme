class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: :User, optional: true

  has_many :hashtag_linkers, dependent: :destroy
  has_many :hashtags, through: :hashtag_linkers

  validates :body, { presence: true,
                     length: { maximum: 280 } }

  after_save_commit :update_hashtags

  def update_hashtags
    self.hashtags =
      question_hashtags.map { |tag| Hashtag.find_or_create_by(text: tag.delete('#')) }
  end

  private

  def question_hashtags
    body_hashtags = get_string_hashtags(body)
    answer_hashtags = get_string_hashtags(answer)

    (body_hashtags + answer_hashtags).uniq
  end

  def get_string_hashtags(str)
    if str.nil?
      []
    else
      str.scan(/#[[:word:]-]+/).map(&:downcase)
    end
  end
end
