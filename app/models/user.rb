class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments

  after_commit :clear_users_cache

  ADMIN_EMAILS = [ "sohamchavan@gmail.com" ].freeze

  def admin?
    ADMIN_EMAILS.include?(email)
  end


  private

  def clear_users_cache
    Rails.cache.delete("users")
  end
end
