task :save_text_from_pdfs => :environment do
	Whitepaper.all.each do |wp|
		if wp.fulltext.nil?
			binding.pry
			io = open(wp.whitepaper.current_path)
			reader = PDF::Reader.new(io)
			wp.fulltext = ""
			reader.pages.each do |page|
				wp.fulltext += page.text
			end
			wp.save
		end
	end
end

