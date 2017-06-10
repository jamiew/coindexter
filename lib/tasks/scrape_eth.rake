task :scrape_eth => :environment do

	eth = Network.friendly.find('ethereum')
	wp = eth.whitepapers.first
	url = wp.url
	puts 'url is #{url}'
	if URI.parse(url).host == 'github.com'
		if url.include? 'Documentation'
			raw_url = url.gsub('https://github.com/','https://raw.githubusercontent.com/')
			raw_url = raw_url.gsub('blob/master','master')
			doc = Nokogiri::HTML(open(raw_url))
			text = doc.children[1].children[0].children[0].children[0].text
			wp.fulltext = text
		elsif url.include? 'wiki'
			doc = Nokogiri::HTML(open(url))
			text = doc.css('div#wiki-body').text
		end
	end

end