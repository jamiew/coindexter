class UploadWhitepaperWorker
  include Sidekiq::Worker

  def perform(*args)
	whitepaper = Whitepaper.find(whitepaper_id)
	whitepaper.key = whitepaper_key
	whitepaper.whitepaper_url = whitepaper.whitepaper.direct_fog_url(:with_path => true)
	user.save!
  end
end
