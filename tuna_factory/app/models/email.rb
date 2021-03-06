require 'mail'
require 'resolv'
require 'socket'

class Email < ActiveRecord::Base

	has_many :fingerprint_matches

	def servers
		Mail.new(self.fulltext).received
	end
	
	def grab_interesting
		interesting = []
		Mail.new(self.fulltext).received.each do |server|
			interesting << server unless server =~ /10\.224/ or
							server =~  /10\.42/
		end
	end
	
	def reachable_path
	  reachable = []
	  self.path.split(" ").each do |server|
	    begin
	      timeout(1) do
          if TCPSocket::new( server, "smtp" )
            reachable << server
          end
        end
	    rescue Exception => e
	      reachable << "unreachable"
	    end
	  end
	  
	  return reachable
  end
	
	def pingable_path
	  pingable = []
	  self.path.split(" ").each do |server|
	    begin
	      pingable << ::Ping.pingecho(server,1)
	    rescue Exception => e
	      pingable << "no response"
	    end
	  end
	  
	  return pingable
  end
  
  def resolved_path
	  resolved = []
	  self.path.split(" ").each do |server|
	    begin
	      resolved << `host #{server}`.split(" ").last
	    rescue Exception => e
	      resolved << "unreachable"
	    end
	  end
	  
	  return resolved
  end
	
	
	def grab_mx
		mail_server_string = `host -t MX #{self.domain}`
		temp = mail_server_string.split("\n")
		mail_servers = []
		temp.each { |string|
			 mail_servers << string.split(" ").last
		}
		return mail_servers			
	end

	def self.search(search, page, sort_order, n=1000)
		  paginate 	:per_page => n,
		  		:page => page,
		  		:order => sort_order,
				  :conditions => ['fulltext like ?', "%#{search}%"]
	end
	
	def contains(string)
		return true if fulltext =~ Regexp.new(string, true)
	end 


	## returns all fingerprints 
	def fingerprint
		matched_fingerprints = nil
		Fingerprint.all.each do |fp|
			puts "Checking for " + fp.description.to_s 
			if fp.check(fulltext)
				matched_fingerprints << fp
			end
		end
		return matched_fingerprints
	end
	
	def text
		return fulltext
	end

end
