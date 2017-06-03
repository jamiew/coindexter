class SaveTextsFromPdfsWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def perform
    Whitepaper.find_each do |wp|
		if wp.fulltext.nil?
			io = open('https://s3.amazonaws.com/coindexter/' + wp.whitepaper.current_path)
			reader = PDF::Reader.new(io)
			wp.fulltext = ""
			reader.pages.each do |page|
				text = page.text.delete "\0"
				wp.fulltext += text
			end
			wp.save
		end
	end
  end

  SaveTextsFromPdfsWorker.perform_async
  
end
