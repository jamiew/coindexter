class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:twitter, :facebook, :google_oauth2]

  mount_uploader :avatar, AvatarUploader

  has_many :coins
  has_many :links
  has_many :comments
  has_many :networks

end
