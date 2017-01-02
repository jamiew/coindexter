class NetworkService < LogService

	attr_accessor :network, :coin, :user

	def get_logs(object, feed_type, limit=nil, user_id=nil)

		if !user_id.nil?
          versions = object.versions.where(:whodunnit => user_id).all.order("created_at DESC").limit(5)
        else
        	if limit.nil?
          		versions = object.versions.all.order("created_at DESC")
          	else
          		versions = object.versions.all.order("created_at DESC").limit(5)
          	end
        end
		
		log_set = []

		versions.each do |version|
			unless version.changeset == {}
		      	set_metadata(created_at: version.created_at, feed_type: feed_type)
		      	convert_changeset(version)
		      	if defined?(version.user) && !version.user.nil?
	    			self.user = version.user
	  			end
				set_coins_and_networks(feed_type, object)
				log_set << self.dup
			end
	    end

		return log_set
	
	end

	def get_all_the_logs
		versions = PaperTrail::Version.all.limit(5).order("created_at DESC")
		
		log_set = []

		versions.each do |version|
			unless version.changeset == {}
		      	set_metadata(created_at: version.created_at, feed_type: feed_type)
		      	convert_changeset(version)
		      	unless version.whodunnit.nil? 
		      		self.user = User.find(version.whodunnit)
		      	end
				if still_exists(version.item_type, version.item_id)
					set_coins_and_networks(version.item_type, version.item_id)
					log_set << self.dup
				end
			end
	    end

		return log_set
	
	end

	def still_exists(item_type, item_id)
		case item_type 
			when "Network"
				unless Network.find(item_id).nil?
					return true
				end
			when "Coin"
				unless Coin.find(item_id).nil?
					return true
				end
			when "Network"
				unless Whitepaper.find(item_id).nil?
					return true
				end
		end
	end


	def set_coins_and_networks(item_type, item_id)
		if item_type == "Network"
			network = Network.find(item_id)
			self.feed_type = "network_log"
			self.networks = network
		elsif item_type == "Whitepaper"
			self.feed_type = "network_log"
			self.networks = network
		else 
			coins = Coin.find(item_id)
			self.feed_type = "coin_log"
			self.coins = coins
		end
		return self
	end

	def convert_changeset(version)
	  	dataset = []
	  	version.changeset.each do |key, value|
		    unless key == "updated_at"
				case key
					when "repositories", "exchanges"
						if value.first == {} || value.first == [] || value.first.nil? || value.first == [""]
						  type = "added"  
						  unless value.first == [""] && value.second.second.nil?
						    abort_log = true
						  end 
						else 
						  type = "edited"
						end
						key == "repositories" ? change_attr = "Repositories" : change_attr = "Exchanges"
					when "network_id"
						if value.first.nil? 
						  type = "added"
						else
						  type = "edited"
						  value[0] = Network.find(value[0])
						end
						value[1] = Network.find(value[1])
						change_attr = "Network"
					when "type"
						change_attr = "Asset type"
					when "created_at"
						abort_log = true
					when "coin_status"
						change_attr = "Status"
					when "code_license"
						change_attr = "Code license"
					when "proof algorithm"
						change_attr = "Proof algorithm"
					when "coin_info"
						change_attr = "Additional info"                
					when "whitepapers", "founders"
						if value.first == {} || value.first == [] || value.first == [""]
						  type = "added"
						  unless value.first == [""] && value.second.second.nil?
						    abort_log = true
						  end  
						else 
						  type = "edited"
						end
					when "description", "application_description	"
						change_attr = "Description"
					when "link"
						change_attr = "Link"
					when "status"
						change_attr = "Status"
					when "id"
						change_attr = "Created"
					else
						change_attr = key
				end
				if value.first == "" || value.first.nil?
				  type = "added"
				else
				  type = "edited"
				end
				if change_attr.nil?
					change_attr = key
				end
				data = set_data(change: value, change_attr: change_attr, change_type: type)
				dataset << data
		    end
	  	end
	  	set_changes(dataset)
	end

	def set_changes(dataset) 
		self.changes = dataset
		return self
	end

	private

        def record_not_found
            render text: "404 Not Found", status: 404
        end

end
