class Question < ApplicationRecord
  validates :body, { presence: { message: 'введите текст вопроса!' },
                     length: { maximum: 280,
                               too_long: '%{count} символов допустимо!' } }
end
