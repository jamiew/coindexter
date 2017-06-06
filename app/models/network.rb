class Network < ApplicationRecord

	has_many :coins
	has_and_belongs_to_many :links
	has_many :comments, through: :links
	has_many :whitepapers
	accepts_nested_attributes_for :whitepapers
	belongs_to :category, optional: true
	belongs_to :user, optional: true
	mount_uploader :logo, NetworkLogoUploader
	extend FriendlyId
	include PgSearch
	multisearchable :against => [:name, :description]
	pg_search_scope :search, :against => :name, :using => { :tsearch => { :prefix => true }, :trigram => { :threshold => 0.1 } }

	validates_uniqueness_of :name

	friendly_id :name, use: [:slugged, :history]

	has_paper_trail :class_name => 'Version', :ignore => [:slug, :updated_at, :category_id]

	enum network_status_options: [:concept, :preproduction, :live, :dead]
	
	validate :correct_dimensions?, :if => :logo_changed?

    def correct_dimensions?
	  image = MiniMagick::Image.open(logo.path)
	  if image[:width] != image[:height]
	    errors.add :logo, "The dimensions of the logo must be a square" 
	  end
  	end

	acts_as_followable

	def should_generate_new_friendly_id?
	  slug.blank? || name_changed?
	end
	
end
