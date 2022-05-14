class Hashtag < ApplicationRecord
  has_many :hashtag_linkers
  has_many :questions, through: :hashtag_linkers

  validates :text, uniqueness: true
end
