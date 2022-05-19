class Hashtag < ApplicationRecord
  extend FriendlyId

  has_many :hashtag_linkers, dependent: :destroy
  has_many :questions, through: :hashtag_linkers

  validates :text, presence: true

  scope :with_questions, lambda {
                           left_joins(:hashtag_linkers)
                             .where.not(hashtag_linkers: { question_id: nil })
                             .distinct
                             .order(created_at: :desc)
                         }

  friendly_id :text, use: :slugged
end
