class Category < ApplicationRecord
	has_many :networks
	has_many :coins, -> {order "market_cap DESC"}
	has_many :links
	extend FriendlyId
  	friendly_id :name, use: :slugged
  	include PgSearch
  	multisearchable :against => [:name]
end
