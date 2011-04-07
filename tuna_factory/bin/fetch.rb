#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/../config/boot'
require 'daemon'
require 'yaml'
require 'fetcher'

class MailFetcherDaemon < Daemon::Base
  
  @config = YAML.load_file("#{RAILS_ROOT}/config/fetcher.yml")
  @config = @config[RAILS_ENV]
  @sleep_time = 60
  
  def self.start
    puts "Starting MailFetcher"
    # Add your own receiver object below and specify fetcher subclass
    @fetcher = Fetcher::Imap.new({:receiver => IncomingMailFetcher}.merge(@config))

    loop do
      @fetcher.fetch
      sleep(@sleep_time)
    end

  end
  
end
