class Network < ApplicationRecord

	has_many :coins
	has_and_belongs_to_many :links
	has_many :comments, through: :links
	belongs_to :category, optional: true
	belongs_to :user, optional: true
	mount_uploader :logo, NetworkLogoUploader
	mount_uploaders :whitepapers, NetworkWhitepapersUploader
	extend FriendlyId
	include PgSearch
	multisearchable :against => [:name, :description]
	pg_search_scope :search, :against => :name, :using => { :tsearch => { :prefix => true }, :trigram => { :threshold => 0.1 } }

	validates_uniqueness_of :name

	friendly_id :name, use: [:slugged, :history]

	has_paper_trail :class_name => 'Version', :ignore => [:slug, :updated_at, :category_id]

	enum network_status_options: [:concept, :preproduction, :live, :dead]
=begin
	def whitepapers
	    read_attribute(:whitepapers).map {|w| Whitepaper.new(w) }
	end

	class Whitepaper
		attr_accessor :title, :url, :pdf

		def initialize(hash)
		  @title = hash['title']
		  @url = hash['url']
		  @pdf = hash['pdf'].force_encoding("UTF-8")
		end

		def persisted?() false; end
		def new_record?() false; end
		def marked_for_destruction?() false; end
		def _destroy() false; end

	end

	def whitepapers_attributes=(attributes)
		whitepapers = []
		attributes.each do |index, attrs|
		  next if '1' == attrs.delete("_destroy")
		  whitepapers << attrs
		end
		whitepaper_changed(whitepapers)
	end

	def build_whitepaper
		w = self.whitepapers.dup
		w << Whitepaper.new({title: '', url: '', pdf: ''})
		self.whitepapers = w
	end

	def whitepaper_changed(whitepapers)
	    any_changes = false
	    if self.whitepapers.length != whitepapers.length
	      any_changes = true
	    else
	      self.whitepapers.each_with_index do |whitepaper, i|
	        if whitepaper.title != whitepapers[i]["title"] || whitepaper.url != whitepapers[i]["url"] || whitepaper.pdf != whitepapers[i]["pdf"]
	          any_changes = true
	        end
	      end
	    end
	    if any_changes
	      write_attribute(:whitepapers, whitepapers)
	    end
  	end
=end

end
