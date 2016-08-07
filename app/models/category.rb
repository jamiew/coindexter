class Category < ApplicationRecord
	has_many :projects
	has_many :coins, through: :projects
	has_many :links, through: :projects
	extend FriendlyId
  	friendly_id :name, use: :slugged
  	include PgSearch
  	multisearchable :against => [:name]
end
