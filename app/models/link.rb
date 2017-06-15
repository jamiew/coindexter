class Link < ApplicationRecord
	has_and_belongs_to_many :coins
	extend FriendlyId
	friendly_id :title, use: [:slugged, :history]
	has_many :comments, as: :commentable
	belongs_to :user
	has_and_belongs_to_many :networks
	attr_accessor :comment_count

  include PgSearch
  multisearchable :against => [:title]
  pg_search_scope :search, :against => :title, :using => { :tsearch => { :prefix => true }, :trigram => { :threshold => 0.3 } }

  default_scope { order('created_at DESC') }

	def should_generate_new_friendly_id?
		!has_friendly_id_slug? || title_changed?
  	end

  	def has_friendly_id_slug?
    	slugs.where(slug: slug).exists?
  	end

  	def comment_count
  		counter = self.comments.count
  		self.comments.each do |comment| 
  			counter += comment.comments.count
  			comment.comments.each do |comment|
  				counter += comment.comments.count
  			end
  		end
  		return counter
  	end
end
