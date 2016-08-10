class Category < ApplicationRecord
	has_many :networks
	has_many :coins, through: :networks
	has_many :links, through: :networks
	extend FriendlyId
  	friendly_id :name, use: :slugged
  	include PgSearch
  	multisearchable :against => [:name]
end
