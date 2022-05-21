class User < ApplicationRecord
  attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: { admin: 0, manager: 1, nurse: 2, carer: 3, family: 4 }

  validates :role, presence: true
  validates :username, uniqueness: { case_sensitive: false }, allow_nil: true
  # Allow only letters and dots in the username
  validates_format_of :username, with: /^[a-zA-Z\.]*$/, multiline: true

  # To allow signing in using either username or email
  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
