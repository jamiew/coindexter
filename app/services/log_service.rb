class LogService 

	attr_accessor :created_at, :feed_type, :change, :change_attr, :change_type, :data, :networks, :coins, :user, :changes

	def set_metadata(user: nil, created_at: nil, feed_type: nil) 
		self.user = user
		self.created_at = created_at
		self.feed_type = feed_type
		return self
	end 


	def set_data(change: nil, change_attr: nil, change_type:nil) 
		data = {
		  change: change,
		  change_type: change_type,
		  change_attr: change_attr
		}
		return data
	end 

end