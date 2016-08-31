class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  before_create :generate_confirmation_token, if: :confirmation_required?

  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:twitter, :facebook, :google_oauth2]

  include CarrierWave::MiniMagick

  mount_uploader :avatar, AvatarUploader

  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  has_many :coins
  has_many :links
  has_many :comments
  has_many :networks
  has_many :logs, :foreign_key => 'whodunnit', :class_name => "Version"

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end
  
  private

  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  protected
    def confirmation_required?
      true
    end

end
