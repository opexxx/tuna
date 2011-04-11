class Fingerprint < ActiveRecord::Base

	has_many :fingerprint_matches

=begin
	def check(text)
		puts "Checking: #{text} for #{regex}"
		if text =~ Regexp.new(self.regex,true)
			return true
		end
	end
=end

	def match(email)
		puts "Trying: #{regex}"
		if email.fulltext =~ Regexp.new(self.regex,true)
  
			## Check to see if we already have this fingerprint
			f = FingerprintMatch.find_by_email_id email.id	
			if f
				return if f.fingerprint_id == self.id and f.email_id == email.id
			end
			
			puts "Matched: #{regex}"				
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
