class User < ApplicationRecord
  has_secure_password

  validates :email, :nickname, :name, presence: { message: 'не может быть пустым!' }

  validates :nickname, { uniqueness: { message: '%{value} уже занят!' },
                         format: { with: /\A[a-zA-Z_1-9]+\z/,
                                   message: "может содержать только латинские буквы, цифры, и знак '_'!" },
                         length: { maximum: 40,
                                   message: 'максимальная длинна - 40 символов!' } }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'неверный формат!' }
end
