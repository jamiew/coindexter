class Whitepaper < ApplicationRecord
	mount_uploader :whitepaper, WhitepaperUploader
	belongs_to :network
	belongs_to :user
	extend FriendlyId
	friendly_id :whitepaper_title, use: [:slugged, :history]
	include PgSearch
	multisearchable :against => [:whitepaper_title, :fulltext]
	pg_search_scope :search, :against => :fulltext, :using => { :tsearch => { :prefix => true }}
	# has_paper_trail :class_name => 'Version', :ignore => [:slug, :updated_at, :fulltext, :whitepaper_title]
	validates_presence_of :whitepaper_title

	def is_external?
		!external_url.nil?
	end

end
