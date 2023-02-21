class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable, :registerable, jwt_revocation_strategy: JwtDenylist

  enum role: [:builder, :scientist, :doctor]

  has_many :dinosaurs

  validates :role, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  def password_required?
    [persisted?, password.nil?, password_confirmation.nil?].any?(false)
  end
end
