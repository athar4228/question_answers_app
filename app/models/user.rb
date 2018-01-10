class User < ApplicationRecord

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true

  def self.find_or_create_from_auth_hash(auth)
    self.where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider    = auth.provider
      user.uid         = auth.uid
      user.first_name  = auth.info.first_name
      user.last_name   = auth.info.last_name
      user.email       = auth.info.email
      user.save!
    end
  end
end