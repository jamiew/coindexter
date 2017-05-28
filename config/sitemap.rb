# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://coindexter.io"
SitemapGenerator::Sitemap.sitemaps_host = "http://s3.amazonaws.com/sitemap-generator/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do

  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #

  Network.find_each do |network|
    add network_path(network)
  end

  Coin.find_each do |coin|
    add network_coin_path(coin.network, coin)
  end

  Whitepaper.find_each do |whitepaper|
    add network_whitepaper_path(whitepaper.network, whitepaper)
  end 

end
