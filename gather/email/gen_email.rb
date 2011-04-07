#!/usr/bin/ruby 

require 'pony'

def random_alphanumeric(size=16)
  s = ""
  size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
  s
end

f = File.open("domains.txt")
out = File.open("checked.txt", "w")
## generate email addresses
emails = []


f.each_line do |domain| 
	domain.chomp!
	name = random_alphanumeric(30)
	out.puts "#{name}, #{name}@#{domain}" ## probably won't work
#	emails << "postmaster@#{domain}"
#	emails << "admin@#{domain}"
#	emails << "john@#{domain}"
end



