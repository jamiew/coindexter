class SaveTextsFromPdfsWorker
  include Sidekiq::Worker
  require 'nokogiri'
  require 'open-uri'
  sidekiq_options :retry => 1

  def perform
    Whitepaper.find_each do |wp|
		if wp.fulltext.nil?
			if !wp.whitepaper.nil?
				io = open('https://s3.amazonaws.com/coindexter/' + wp.whitepaper.current_path)
				reader = PDF::Reader.new(io)
				wp.fulltext = ""
				reader.pages.each do |page|
					text = page.text.delete "\0"
					wp.fulltext += text
				end
			elsif !url.nil? 
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
