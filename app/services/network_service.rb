class NetworkService < LogService

	attr_accessor :network, :coin, :user
	
	def get_logs(object, feed_type, limit=nil, user_id=nil)

		if !user_id.nil?
			puts "hey"
          versions = object.versions.where(:whodunnit => user_id).all.order("created_at DESC").limit(5)
        else
        	if limit.nil?
          		versions = object.versions.all.order("created_at DESC")
          	else
          		versions = object.versions.all.order("created_at DESC").limit(5)
          	end
        end

        puts "versions are #{versions.inspect}"
		
		log_set = []

		versions.each do |version|
			unless version.changeset == {}
				unless !convert_changeset(version)
			      	set_metadata(created_at: version.created_at, feed_type: feed_type)
			      	if defined?(version.user) && !version.user.nil?
		    			self.user = version.user
		  			end
					set_coins_and_networks(object)
					log_set << self.dup
				end
			end
	    end

		return log_set
	
	end

	def set_coins_and_networks(object)
		if feed_type == "coin_log"
			self.coins = object
		else 
			self.networks = object
		end
		return self
	end

	def convert_changeset(version)
	  version.changeset.each do |key, value|
	    unless key == "updated_at"
	      type = nil
	      abort_log = false
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
	      when "description"
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
	      if type.nil?
	        if value.first == "" || value.nil?
	          type = "added"
	        else
	          type = "edited"
	        end
	      end
	      if change_attr.nil?
	        change_attr = key
	      end
	      if abort_log
	        return false
	      else
	        self.set_data(change: value, change_attr: change_attr, change_type: type)
	        return self
	      end
	    end
	  end
	end

end
