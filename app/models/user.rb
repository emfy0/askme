class User < ApplicationRecord
  extend FriendlyId
  include Gravtastic

  before_validation :downcase_nickname_email

  validates :email, :nickname, :name, presence: true

  validates :nickname, { uniqueness: true,
                         format: { with: /\A[a-z_1-9]+\z/ },
                         length: { maximum: 40 } }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  validates :header_color, { format: { with: /\A#(?:\h{3}){1,2}\z/ } }

  has_secure_password

  has_many :questions, dependent: :delete_all

  gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')

  friendly_id :nickname, use: :slugged

  scope :sort_by_reg_date, -> { order(created_at: :desc) }

  private

  def downcase_nickname_email
    nickname&.downcase!
    email&.downcase!
  end
end
