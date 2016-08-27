class LogService
  attr_accessor :data, :user, :created_at, :feed_type, :networks, :coins

  def set_data(change: nil, change_attr: nil, change_type:nil) 
    self.data = {
      change: change,
      change_type: change_type,
      change_attr: change_attr
    }
    return self
  end  
end