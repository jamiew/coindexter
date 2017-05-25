class TestBallWorker
  include Sidekiq::Worker

  def perform
  	puts 'hey'
  	logger.info 'hey'
  end

  TestBallWorker.perform_async

end