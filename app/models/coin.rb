class Coin < ApplicationRecord
  belongs_to :category, optional: true
  mount_uploader :logo, LogoUploader
  extend FriendlyId
  include PgSearch
  multisearchable :against => [:name, :application_name, :application_description]
  pg_search_scope :search, :against => {:name => 'A',:application_name => 'B',:application_description  => 'C'}, :using => { :tsearch => { :prefix => true }, :trigram => { :threshold => 0.1 } }

  validates_uniqueness_of :name

  friendly_id :name, use: [:slugged, :history]

  has_many :links

  def should_generate_new_friendly_id?
	 !has_friendly_id_slug? || name_changed?
  end

  def has_friendly_id_slug?
    slugs.where(slug: slug).exists?
  end

  def update_prices
    response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/' + name.downcase)
    unless response[0].nil?
      price = response[0]["price_usd"]
      one_hour_price_change = response[0]["percent_change_1h"]
      one_day_price_change = response[0]["percent_change_24h"]
      available_supply = response[0]["available_supply"]
      total_supply = response[0]["total_supply"]
      market_cap = response[0]["market_cap_usd"]
      update_attributes(:price => price,:one_day_price_change => one_day_price_change, :one_hour_price_change => one_hour_price_change, :available_supply => available_supply, :total_supply => total_supply, :market_cap => market_cap)
    end
  end

end
