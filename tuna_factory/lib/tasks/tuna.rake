$:.unshift(File.join(File.dirname(__FILE__), "..", "tuna"))

require 'process'

namespace :tuna do

	task :import_fingerprints => :environment do
  	@fingerprint_file = ENV["TUNA_FINGERPRINT_FILE"]
		f = EmailFingerprinter.new
		f.load_fingerprints(@fingerprint_file)
	end
	
	task :export_fingerprints => :environment do
	  	f = EmailFingerprinter.new
  		f.export_fingerprints
	end
	
	task :process => :environment do
		tuna_dir = ENV["TUNA_DIR"]
		puts "Tuna Directory: #{tuna_dir}"
		e  = EmailProcessor.new(tuna_dir)
		e.process
	end
	
	desc "Process and Fingerprint Emails"
	task :process_and_fingerprint => :environment do
		tuna_dir = ENV["TUNA_DIR"]
		puts "Tuna Directory: #{tuna_dir}"
		e  = EmailProcessor.new(tuna_dir)
		e.process_and_fingerprint
	end
	
	desc "Fingerprint Email"
	task :fingerprint => :environment do
		f  = EmailFingerprinter.new
		f.fingerprint_all
	end
	
	desc "Reset"
	task :reset => [ "db:drop", "tuna:setup"] do
		puts "reset the environment!"
	end

	desc "Setup"
	task :setup => [ "db:create", "db:migrate", "tuna:process_and_fingerprint"] do
		puts "set up the environment!"
	end

	
end
