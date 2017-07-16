class SaveTextsFromPdfsWorker
  include Sidekiq::Worker
  require 'nokogiri'
  require 'open-uri'
  sidekiq_options({
    unique: :all,
    expiration: 24 * 60 * 60
  })
  sidekiq_options :retry => false

  def perform
    Whitepaper.find_each do |wp|
		if wp.fulltext.nil?
			if !wp.whitepaper.url.nil?
				io = open('https://s3.amazonaws.com/coindexter/' + wp.whitepaper.current_path)
				reader = PDF::Reader.new(io)
				wp.fulltext = ""
				reader.pages.each do |page|
					text = page.text.delete "\0"
					wp.fulltext += text
				end
			elsif !wp.external_url.nil? 
				if URI.parse(wp.external_url).host == 'github.com'
					puts 'host is github'
					if wp.external_url.include? 'Documentation'
						raw_url = external_url.gsub('https://github.com/','https://raw.githubusercontent.com/')
						raw_url = raw_url.gsub('blob/master','master')
						doc = Nokogiri::HTML(open(raw_url))
						text = doc.children[1].children[0].children[0].children[0].text
						wp.fulltext = text
					elsif wp.external_url.include? 'wiki'
						doc = Nokogiri::HTML(open(wp.external_url))
						text = doc.css('div#wiki-body').text
						wp.fulltext = text
					end
				else 
					doc = Nokogiri::HTML(open(wp.external_url))
					if doc.search("meta[property='al:ios:app_name']").map { |n| n['content']}.first == "Medium"
						text = doc.css("div.section-inner").text
						wp.fulltext = text
						puts "saving #{wp.external_url} full text"
					end
				end
			end
			wp.save
		end
	end
  end

  # SaveTextsFromPdfsWorker.perform_async
  
end
