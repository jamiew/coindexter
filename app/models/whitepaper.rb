class Whitepaper < ApplicationRecord
	mount_uploader :whitepaper, WhitepaperUploader
	belongs_to :network
	extend FriendlyId
	friendly_id :whitepaper_title, use: [:slugged, :history]
	include PgSearch
	multisearchable :against => [:whitepaper_title, :fulltext]
	pg_search_scope :search, :against => :fulltext, :using => { :tsearch => { :prefix => true }}
end