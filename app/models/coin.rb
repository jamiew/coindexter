class Coin < ApplicationRecord

	validates :name, presence: true, length: { maximum: 255 },
                  uniqueness: { case_sensitive: false }
	validates :info_status, presence: true, length: { maximum: 255 }
	validates :info_additional, presence: true, length: { maximum: 255 }
	validates :application_name, presence: true, length: { maximum: 255 }
	validates :application_description, presence: true, length: { maximum: 255 }
	validates :application_status, presence: true, length: { maximum: 255 }
	validates :application_category, presence: true, length: { maximum: 255 }

	belongs_to :category
	belongs_to :status

end
