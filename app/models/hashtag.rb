class Hashtag < ApplicationRecord
  has_many :hashtag_linkers
  has_many :questions, through: :hashtag_linkers

  validates :text, uniqueness: true

  def self.delete_unassociated_hashtags
    self.left_joins(:hashtag_linkers).where(hashtag_linkers: { question_id: nil }).delete_all
  end
end
