class SaveTextsFromPdfsWorker
  include Sidekiq::Worker

  def perform
    Whitepaper.all.each do |wp|
		if wp.fulltext.nil?
			io = open('https://s3.amazonaws.com/coindexter/' + wp.whitepaper.current_path)
			reader = PDF::Reader.new(io)
			wp.fulltext = ""
			reader.pages.each do |page|
				wp.fulltext += page.text
			end
			wp.save
		end
	end
  end

  SaveTextsFromPdfsWorker.perform_async
  
end
