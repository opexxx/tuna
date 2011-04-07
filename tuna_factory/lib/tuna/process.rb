require 'mail'

class EmailProcessor
	def initialize(directory = nil)
		if directory
			@directory = directory
		else
			@directory = Rails.root + "../mail/"
		end
	end
	
	def process
		puts "Processing email in #{@directory}"
		emails = Dir.glob("#{@directory}/*")
		emails.each do |email|

			begin
				text = File.open(email).read

				m = Mail.new(text)
				
				path = []
				m.received.each {|server|
					path << server.to_s.split(' ')[1]
				}
				
				gmail_path = []
				gmail_path << 2.times{path.shift}

				Email.create(	:fulltext => text, 
						:from => m.from, 
						:to => m.to, 
						:domain => m.from.first.split("@").last,
						#:header => m.header,
						:gmail_path => gmail_path,
						:path => path.join(" "),
						:received => m.received,
						:distance => path.count)
			rescue Exception => e
				puts e.inspect
			end			

		end
	end

	def load_fingerprints
		fingerprint_db = File.join(Rails.root, 'data', 'fingerprints.yml')
		YAML.load_file(fingerprint_db).each do |fingerprint_def| 
						f = Fingerprint.new
						f.load_from_hash(fingerprint_def)
						f.save
		end
	end
end



