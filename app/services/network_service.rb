class NetworkService < LogService

	attr_accessor :network, :coin, :user

	def get_logs(object, feed_type, limit=nil, user_id=nil, since=nil)

		if !user_id.nil?
          	versions = object.versions.where(:whodunnit => user_id).all.order("created_at DESC").limit(5)
        else
        	if limit.nil?
          		if since.nil?
          			versions = object.versions.all.order("created_at DESC")
          		else 
          			versions = object.versions.where("created_at > ?",since.day.ago).order("created_at DESC")
          		end
          	else
          		versions = object.versions.all.order("created_at DESC").limit(5)
          	end
        end
		
		log_set = []

		versions.each do |version|
			unless version.changeset == {} or !still_exists(version.item_type, version.item_id) or !is_worth_showing(version.changeset)
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

	def get_all_the_logs(user_id=nil)
		
		if user_id.nil?
			versions = PaperTrail::Version.all.where.not(whodunnit: 40).limit(5).order("created_at DESC")
		else
			versions = PaperTrail::Version.all.where(:whodunnit => user_id).limit(5).order("created_at DESC")
		end
		log_set = []

		versions.each do |version|
			unless version.changeset == {} or !still_exists(version.item_type, version.item_id) or !is_worth_showing(version.changeset)
		      	set_metadata(created_at: version.created_at, feed_type: feed_type)
		      	convert_changeset(version)
		      	unless version.whodunnit.nil? 
		      		self.user = User.find(version.whodunnit)
		      	end
				set_coins_and_networks(version.item_type, version.item_id)
				log_set << self.dup
			end
	    end

		return log_set
	
	end

	def still_exists(item_type, item_id)
		case item_type 
			when "Network"
				if Network.exists?(:id => item_id)
					return true
				end
			when "Coin"
				if Coin.exists?(:id => item_id)
					return true
				end
			when "Whitepaper"
				if Whitepaper.exists?(:id => item_id)
					return true
				end
		end
	end

	def is_worth_showing(changeset)
		is_not_empty = false
		changeset.each do |k,v|
			unless (v.first.nil? or v.first.blank?) and (v.second.nil? or v.second.blank?)
				is_not_empty = true
			end
		end
		return is_not_empty
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
						  unless value[0].nil?
						  	value[0] = Network.find(value[0])
						  end
						end
						if value[1].nil?
							value[1] = ""
						else	
							value[1] = Network.find(value[1])
						end
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
					when "founders", "whitepapers"
						if value.first == {} || value.first == [] || value.first == [""]
						  type = "added"
						  if value.first == [""] && value.second.nil?
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
					when "capital_raised"
						change_attr = "ICO: Capital raised"
					when "ico_use_of_proceeds"
						change_attr = "ICO: Use of proceeds"
					when "ico_token_sale_structure"
						change_attr = "ICO: Token sale structure"
					when "ico_pricing"
						change_attr = "ICO: Initial pricing"
					when "ico_amount_sold"
						change_attr = "ICO: Amount sold"
					when "ico_allocation"
						change_attr = "ICO: Allocation"
					when "ico_lockup"
						change_attr = "ICO: Lockup"
					when "ico_buyer_lockup"
						change_attr = "ICO: Buyers' lockup"
					when "ico_founder_lockup"
						change_attr = "ICO: Founders' lockup"
					when "ico_min_investment_cap"
						change_attr = "ICO: minimum investment cap"
					when "ico_type_of_min_cap"
						change_attr = "ICO Type of minimum cap"
					when "ico_type_of_max_cap"
						change_attr = "ICO Type of maximum cap"
					when "ico_max_investment_cap"
						change_attr = "ICO maximum investment cap"
					when "ico_currency_accepted"
						change_attr = "Currency accepted"
					when "ico_additional_notes"
						change_attr = "ICO: Additional notes"
					when "ico_planned_end_date"
						change_attr = "ICO: Planned end date"
					when "ico_actual_end_date"
						change_attr = "ICO: Planned start date"
					when "saledate"
						change_attr = "ICO: Sale start date"
					when "id"
						change_attr = "Created"
					else
						change_attr = key
				end
				if type.nil?
					if value.first == "" || value.first.nil?
						type = "added"
					else
						type = "edited"
					end
				end
				if change_attr.nil?
			    	change_attr = key
			    end
				if abort_log
			        break
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
