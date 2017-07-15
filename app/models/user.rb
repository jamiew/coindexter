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

  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }, presence: true, uniqueness: true

  validates :avatar, presence: true

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates_presence_of   :email
  validates_uniqueness_of :email, allow_blank: true
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise.password_length, allow_blank: false, if: :password_required?

  # validate :check_dimensions

  def check_dimensions
    errors.add :avatar, "must be square" if avatar.width != avatar.height
  end

  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end

  def password_required?
    new_record? ? super : false
  end

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  protected
    def confirmation_required?
      true
    end

end
