class Question < ApplicationRecord
  validates :body, { presence: true,
                     length: { maximum: 280,
                               too_long: '%{count} символов допустимо!' } }
end
