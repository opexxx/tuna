require 'mail'

class EmailFingerprinter

	attr_accessor :fingerprint_file

	def initialize(load_from_file = false)
		@fingerprint_file = Rails.root + 'data/fingerprints.yml'
		if load_from_file
		    load_fingerprints(@fingerprint_file)
		end
	end
	
	def fingerprint_all
		Email.all.each do |email|
			self.fingerprint(email)
		end
	end
	
	def fingerprint(email)
		Fingerprint.all.each do |fingerprint| 
			puts "Checking for... #{fingerprint.id}"
			fingerprint.match(email)
		end
	end

	def load_fingerprints(file)
	  return unless file
	  
		YAML.load_file(file).each do |fingerprint_def| 
            		puts "Creating fingerprint for: #{fingerprint_def['name']}"
		        x = Fingerprint.find_by_name fingerprint_def["name"]
			if !x 
				f = Fingerprint.new
				f.from_yaml(fingerprint_def)
				f.save!
			else
				puts "Already have fingerprint #{fingerprint_def['name']}"
			end
		end
	end

	def export_fingerprints
	  Fingerprint.all.each do |fingerprint|
	    puts fingerprint.to_yaml
	  end
	end
end

class EmailProcessor

	def initialize(directory = nil)
		if !directory
			@directory = Rails.root + "../data/test"
		else
			@directory = directory
		end
		
		puts "Set Tuna directory to #{@directory}"
	end

  def process
		puts "Processing email in #{@directory}"
    
    		### Process the provided email
		emails = Dir.glob("#{@directory}/*")
		emails.each do |email|

			begin
        puts "Parsing email..."
				text = File.open(email).read

				m = Mail.new(text)
				
				path = []
				m.received.each {|server|
					path << server.to_s.split(' ')[1]
				}
				
				gmail_path = []
				gmail_path << 2.times{path.shift}

				e = Email.create( :fulltext => text, 
						  :from => m.from, 
						  :to => m.to, 
						  :domain => m.from.first.split("@").last,
						  :gmail_path => gmail_path,
						  :path => path.join(" "),
						  :received => m.received,
						  :distance => path.count)		
			rescue Exception => except
				puts except.inspect
			end			
		end
	end
		
	def process_and_fingerprint
		puts "Processing and fingerprinting email in #{@directory}"
		@fingerprinter = EmailFingerprinter.new
		
    ### Process the provided email
		emails = Dir.glob("#{@directory}/*")
		emails.each do |email|

			begin
			        puts "Parsing email..."
				text = File.open(email).read

				m = Mail.new(text)
				
				path = []
				m.received.each {|server|
					path << server.to_s.split(' ')[1]
				}
				
				gmail_path = []
				gmail_path << 2.times{path.shift}

				e = Email.create( :fulltext => text, 
						  :from => m.from, 
						  :to => m.to, 
						  :domain => m.from.first.split("@").last,
						  :gmail_path => gmail_path,
						  :path => path.join(" "),
						  :received => m.received,
						  :distance => path.count)

				puts  "Fingerprinting...."
				@fingerprinter.fingerprint(e)
						
			rescue Exception => e
				puts e.inspect
			end			

		end
	end
end
