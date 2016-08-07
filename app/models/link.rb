class Link < ApplicationRecord
	has_many :coins
	extend FriendlyId
	friendly_id :title, use: [:slugged, :history]
	accepts_nested_attributes_for :coins
	has_many :comments, as: :commentable
	belongs_to :user
	belongs_to :project

	def has_coins 
    	coins
	end

	def should_generate_new_friendly_id?
		!has_friendly_id_slug? || title_changed?
  	end

  	def has_friendly_id_slug?
    	slugs.where(slug: slug).exists?
  	end
end
