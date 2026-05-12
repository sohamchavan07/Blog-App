class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts
  has_many :comments

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming you want to store full name
      user.avatar_url = auth.info.image # assuming you want to store avatar url
      # If you are using confirmable and the provider already confirms emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  ADMIN_EMAILS = [ "[EMAIL_ADDRESS]" ].freeze

  def admin?
    ADMIN_EMAILS.include?(email)
  end


  private

  def clear_users_cache
    Rails.cache.delete("users")
  end
end
