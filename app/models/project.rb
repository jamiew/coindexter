class Project < ApplicationRecord

	has_many :coins
	belongs_to :category, optional: true
	belongs_to :user, optional: true
	mount_uploader :logo, ProjectLogoUploader
	extend FriendlyId
	include PgSearch
	multisearchable :against => [:name, :description]
	pg_search_scope :search, :against => :name, :using => { :tsearch => { :prefix => true }, :trigram => { :threshold => 0.1 } }

	validates_uniqueness_of :name

	friendly_id :name, use: [:slugged, :history]

end
