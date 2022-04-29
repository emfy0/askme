class User < ApplicationRecord
  has_secure_password

  validates :email, :nickname, :name, presence: true

  validates :nickname, { uniqueness: {},
                         format: { with: /\A[a-zA-Z_1-9]+\z/ },
                         length: { maximum: 40 } }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :header_color, { format: { with: /\A#(?:\h{3}){1,2}\z/ } }
end
