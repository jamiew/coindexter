class Link < ApplicationRecord
	has_many :coins
	extend FriendlyId

	def should_generate_new_friendly_id?
		!has_friendly_id_slug? || name_changed?
  	end

  	def has_friendly_id_slug?
    	slugs.where(slug: slug).exists?
  	end
end
