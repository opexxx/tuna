class Fingerprint < ActiveRecord::Base
	
	has_many :fingerprint_matches
	
	def check(text)
		puts "checking: #{text} for #{regex}"
		if text =~ Regexp.new(self.regex,true)
			return true
		end
	end
	
	def match(email)
	  puts "Email #{email.inspect}"
	  puts "Fingerprint #{self.inspect}"
	  if email.fulltext =~ Regexp.new(self.regex,true)
			FingerprintMatch.create :email_id => email.id, :fingerprint_id => self.id
		end
	end
	
	def self.search(search, page, sort_order, n=100)
		  paginate 	:per_page => n,
		  		      :page => page,
		  		      :order => sort_order,
				        :conditions => ['description like ?', "%#{search}%"]
	end
	
	def load_from_hash(hash)
	  puts "Loading from hash #{hash}"
		self.name  = hash["name"]
		self.regex = hash["regex"]
	  self.description = hash["description"]
		self.confidence = hash["confidence"]
		self.references = hash["references"]
		self.case_sensitive = hash["case"]
	end

end
