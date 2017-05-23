task :save_text_from_pdfs => :environment do
	 SaveTextsFromPdfsWorker.perform_async
end

