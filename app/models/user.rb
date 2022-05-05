class User < ApplicationRecord
  has_secure_password

  validates :email, :nickname, :name, presence: true

  validates :nickname, { uniqueness: true,
                         format: { with: /\A[a-z_1-9]+\z/ },
                         length: { maximum: 40 } }
  before_validation :downcase_nickname

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  validates :header_color, { format: { with: /\A#(?:\h{3}){1,2}\z/ } }

  has_many :questions, dependent: :delete_all

  def downcase_nickname
    nickname.downcase!
  end
end
