class FingerprintMatch < ActiveRecord::Base
  belongs_to :email
  belongs_to :fingerprint
  
  def self.search(search, page, sort_order, n=100)
		  paginate 	:per_page => n,
		  		      :page => page,
		  		      :order => sort_order,
				        :conditions => ['description like ?', "%#{search}%"]
	end
  
end
