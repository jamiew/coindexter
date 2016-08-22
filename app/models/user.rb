class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:twitter, :facebook, :google_oauth2]

  include CarrierWave::MiniMagick

  mount_uploader :avatar, AvatarUploader

  has_many :coins
  has_many :links
  has_many :comments
  has_many :networks
  has_many :logs, :foreign_key => 'whodunnit', :class_name => "Version"

end
