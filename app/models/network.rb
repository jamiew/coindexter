class Network < ApplicationRecord

	has_many :coins
	has_and_belongs_to_many :links
	has_many :comments, through: :links
	has_many :whitepapers
	accepts_nested_attributes_for :whitepapers
	belongs_to :category, optional: true
	belongs_to :user, optional: true
	include CarrierWave::MiniMagick
	mount_uploader :logo, NetworkLogoUploader
	extend FriendlyId
	include PgSearch
	multisearchable :against => [:name, :description]
	pg_search_scope :search, :against => :name, :using => { :tsearch => { :prefix => true }, :trigram => { :threshold => 0.1 } }

	nilify_blanks

	validates :name, presence: true, uniqueness:true

	friendly_id :name, use: [:slugged, :history]

	has_paper_trail :class_name => 'Version', :ignore => [:slug, :updated_at, :category_id]

	enum network_status_options: [:concept, :preproduction, :live, :dead]

  	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
	after_update :crop_logo

	def crop_logo
		logo.recreate_versions! if crop_x.present?
	end

	acts_as_followable

	def should_generate_new_friendly_id?
	  slug.blank? || name_changed?
	end
	
end
