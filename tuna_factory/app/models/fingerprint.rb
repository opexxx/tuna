class Fingerprint < ActiveRecord::Base
	
	#has_many :emails
	
	def check(text)
		puts "checking: #{text} for #{regex}"
		if text =~ Regexp.new(regex,true)
			return true
		end
	end
	
	
	def self.search(search, page, sort_order, n=100)
		  paginate 	:per_page => n,
		  		:page => page,
		  		:order => sort_order,
				:conditions => ['description like ?', "%#{search}%"]
	end
	
	def load_from_hash(hash)
		regex = hash[:regex]
		description = hash[:description]
		confidence = hash[:confidence]
		references = hash[:references]
		case_sensitive = hash[:case]
	end

end
