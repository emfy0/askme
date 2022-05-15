class Hashtag < ApplicationRecord
  extend FriendlyId

  has_many :hashtag_linkers, dependent: :destroy
  has_many :questions, through: :hashtag_linkers

  validates :text, uniqueness: true

  friendly_id :text, use: :slugged

  def self.delete_unassociated_hashtags
    left_joins(:hashtag_linkers).where(hashtag_linkers: { question_id: nil }).delete_all
  end
end
