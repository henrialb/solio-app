class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  self.skip_session_storage = [:http_auth, :params_auth]

  enum role: { admin: 0, manager: 1, nurse: 2, carer: 3, family: 4 }

  has_one :employee, dependent: :destroy
  has_many :visits, dependent: :destroy

  validates :role, presence: true
end
