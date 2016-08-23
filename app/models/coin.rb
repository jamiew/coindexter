class Coin < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :network, optional: true
  mount_uploader :logo, LogoUploader
  extend FriendlyId
  include PgSearch
  multisearchable :against => [:name]
  pg_search_scope :search, :against => :name, :using => { :tsearch => { :prefix => true }, :trigram => { :threshold => 0.1 } }

  validates_uniqueness_of :name

  friendly_id :name, use: [:slugged, :history]

  has_and_belongs_to_many  :links
  has_many :comments, through: :links

  has_paper_trail :class_name => 'Version', :ignore => [:price, :one_hour_price_change, :one_day_price_change, :volume, :market_cap, :available_supply, :total_supply, :link_id, :links_id, :slug]

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

  def repositories
    read_attribute(:repositories).map {|v| Repository.new(v) }
  end

  class Repository
    attr_accessor :name, :url

    def initialize(hash)
      @name = hash['name']
      @url = hash['url']
    end

    def persisted?() false; end
    def new_record?() false; end
    def marked_for_destruction?() false; end
    def _destroy() false; end

  end

  def repositories_attributes=(attributes)
    repositories = []
    attributes.each do |index, attrs|
      next if attrs["_destroy"] == true
      repositories << attrs
    end
    repository_changed(repositories)
  end

  def build_repository
    r = self.repositories.dup
    r << Repository.new({name: '', url: ''})
    self.repositories = r
  end

  def repository_changed(repos)
    any_changes = false
    if self.repositories.length != repos.length
      any_changes = true
    else
      self.repositories.each_with_index do |repository, i|
        if repository.name != repos[i]["name"] || repository.url != repos[i]["url"]
          any_changes = true
        end
      end
    end
    if any_changes
      write_attribute(:repositories, repos)
    end
  end

end
