class SaveTextsFromPdfsWorker
  include Sidekiq::Worker
  require 'nokogiri'
  require 'open-uri'
  sidekiq_options :retry => 1

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
					if external_url.include? 'Documentation'
						puts 'host includes Documentation'
						raw_url = external_url.gsub('https://github.com/','https://raw.githubusercontent.com/')
						puts 'raw url is #{raw_url}'
						raw_url = raw_url.gsub('blob/master','master')
						puts 'raw url is now #{raw_url}'
						doc = Nokogiri::HTML(open(raw_url))
						puts 'doc is #{doc}'
						text = doc.children[1].children[0].children[0].children[0].text
						puts 'text is #{text}'
						wp.fulltext = text
					elsif url.include? 'wiki'
						doc = Nokogiri::HTML(open(url))
						puts 'doc 2 is #{doc}'
						text = doc.css('div#wiki-body').text
						puts 'text 2 is #{text}'
						wp.fulltext = text
					end
				end
			end
			wp.save
		end
	end
  end

  SaveTextsFromPdfsWorker.perform_async
  
end
