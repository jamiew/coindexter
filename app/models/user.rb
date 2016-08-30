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

end
