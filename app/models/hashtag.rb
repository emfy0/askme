class Hashtag < ApplicationRecord
  extend FriendlyId

  has_many :hashtag_linkers, dependent: :destroy
  has_many :questions, through: :hashtag_linkers

  validates :text, presence: true

  scope :with_questions, -> { where_exists(:questions) }

  friendly_id :text, use: :slugged
end
