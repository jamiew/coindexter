class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :omniauthable, :confirmable, :omniauth_providers => [:twitter, :facebook, :google_oauth2]

  include CarrierWave::MiniMagick

  mount_uploader :avatar, AvatarUploader

  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  has_many :coins
  has_many :links
  has_many :whitepapers
  has_many :comments
  has_many :networks
  has_many :logs, :foreign_key => 'whodunnit', :class_name => "Version"

  acts_as_follower

  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end

  protected
    def confirmation_required?
      true
    end

end
