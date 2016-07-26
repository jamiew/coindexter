class Coin < ApplicationRecord
  belongs_to :category
  validates :category_id, presence: true
  mount_uploader :logo, LogoUploader
  extend FriendlyId

  friendly_id :name, use: [:slugged, :history]

  def should_generate_new_friendly_id?
	!has_friendly_id_slug? || name_changed?
  end

  def has_friendly_id_slug?
    slugs.where(slug: slug).exists?
  end

end
