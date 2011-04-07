$:.unshift(File.join(File.dirname(__FILE__), "..", "tuna"))

require 'process'

namespace :tuna do
	
	desc "Process Emails"
	task :process => :environment do
		tuna_dir = ENV['TUNA_DIR']
		puts "load mail from #{tuna_dir}"
		e  = EmailProcessor.new(tuna_dir)
		e.process
	end

	desc "Load Fingerprints"
	task :load_fingerprints => :environment do
		puts "load fingerprints!"
		e = EmailProcessor.new
		e.load_fingerprints
	end

	desc "Reset"
	task :reset => [ "db:drop", "tuna:setup"] do
		puts "reset the environment!"
	end

	desc "Setup"
	task :setup => [ "db:create", "db:migrate", "tuna:load_fingerprints", "tuna:process"] do
		puts "set up the environment!"
	end

	
end
