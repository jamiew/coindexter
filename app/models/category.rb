class Category < ApplicationRecord
	has_many :coins
	extend FriendlyId
  	friendly_id :name, use: :slugged
  	include PgSearch
  	multisearchable :against => [:name, :application_name]
end
