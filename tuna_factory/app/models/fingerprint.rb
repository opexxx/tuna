class Fingerprint < ActiveRecord::Base

	has_many :fingerprint_matches

	def match(email)
		if email.fulltext =~ Regexp.new(self.regex,true)
			## Check to see if we already have this fingerprint
			f = FingerprintMatch.find_by_email_id email.id	
			if f
				return if f.fingerprint_id == self.id and f.email_id == email.id
			end
			FingerprintMatch.create :email_id => email.id, :fingerprint_id => self.id
		end
	end
	
	def self.search(search, page, sort_order, n=100)
		  paginate 	:per_page => n,
		  		      :page => page,
		  		      :order => sort_order,
				        :conditions => ['description like ?', "%#{search}%"]
	end
	
	def run
	  Email.all.each {|email| self.match(email)}
  end
  
	def from_yaml(hash)
	  puts "Loading from hash #{hash}"
		self.name  = hash["name"]
		self.regex = hash["regex"]
	  self.description = hash["description"]
		self.confidence = hash["confidence"]
		self.severity = hash["severity"]
    self.references = hash["references"].to_a
		self.case_sensitive = hash["case"]
	end
	
	def to_yaml
	  out = ""
	  out += " - name: #{self.name}\n"
	  out += "   regex: #{self.regex}\n"
	  out += "   description: #{self.description}\n"
	  out += "   confidence: #{self.confidence}\n"
	  out += "   severity: #{self.severity}\n"
	  out += "   references:\n"
	  if self.references.respond_to? :each
	    self.references.each{ |reference| out += "    - #{reference}\n"}
	  else
	    out += "   #{self.references}\n"
    end
  end
end
