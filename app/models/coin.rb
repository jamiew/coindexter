class Coin < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :network
  mount_uploader :logo, LogoUploader
  extend FriendlyId
  include PgSearch
  multisearchable :against => [:name]
  pg_search_scope :search, :against => [:name, :symbol] , :using => { :tsearch => { :prefix => true } }


  validates_uniqueness_of :name

  friendly_id :name, use: [:slugged, :history]

  has_and_belongs_to_many  :links
  has_many :comments, through: :links

  has_paper_trail :class_name => 'Version', :ignore => [:price, :one_hour_price_change, :one_day_price_change, :volume, :market_cap, :available_supply, :total_supply, :link_id, :links_id, :slug, :updated_at, :category_id, :saledate]

  enum coin_status_options: [:concept, :preproduction, :live, :dead]

  acts_as_followable

  def correct_dimensions?
    image = MiniMagick::Image.open(logo.path)
    if image[:width] != image[:height]
      errors.add :logo, "The dimensions of the logo must be a square" 
    end
  end

  def should_generate_new_friendly_id?
	 !has_friendly_id_slug? || name_changed?
  end

  def has_friendly_id_slug?
    slugs.where(slug: slug).exists?
  end

  def one_day_up 
    if one_day_price_change > 0 
      self.one_day_up = "up"
    else
      self.one_day_up = "down"
    end
  end

  def one_hour_up 
    if one_hour_price_change > 0 
      self.one_hour_up = "up"
    else
      self.one_hour_up = "down"
    end
  end

=begin

  # Moved to Sidekiq worker 
  
  def update_prices
    response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/' + name.delete(" ").downcase)
    if response[0].nil?
      puts name
      update_attributes(:coin_status => 'concept')
    else
      price = response[0]["price_usd"]
      one_hour_price_change = response[0]["percent_change_1h"]
      one_day_price_change = response[0]["percent_change_24h"]
      available_supply = response[0]["available_supply"]
      total_supply = response[0]["total_supply"]
      market_cap = response[0]["market_cap_usd"]
      update_attributes(:price => price,:one_day_price_change => one_day_price_change, :one_hour_price_change => one_hour_price_change, :available_supply => available_supply, :total_supply => total_supply, :market_cap => market_cap)
    end
  end
=end

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

  def exchanges
    read_attribute(:exchanges).map {|v| Exchange.new(v) }
  end

  class Exchange
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

  def exchanges_attributes=(attributes)
    exchanges = []
    attributes.each do |index, attrs|
      next if attrs["_destroy"] == true
      exchanges << attrs
    end
    exchange_changed(exchanges)
  end

  def build_exchange
    e = self.exchanges.dup
    e << Exchange.new({name: '', url: ''})
    self.exchanges = e
  end

  def exchange_changed(xchanges)
    any_changes = false
    if self.exchanges.length != xchanges.length
      any_changes = true
    else
      self.exchanges.each_with_index do |exchange, i|
        if exchange.name != xchanges[i]["name"] || exchange.url != xchanges[i]["url"]
          any_changes = true
        end
      end
    end
    if any_changes
      write_attribute(:exchanges, xchanges)
    end
  end  

end
