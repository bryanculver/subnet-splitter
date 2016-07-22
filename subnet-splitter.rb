#!/usr/bin/env ruby
require 'rubygems'
require 'ipaddress'

if !ARGV[0] || ARGV[0].length == 0 || /^[^0-9].*/.match(ARGV[0]) then
  # LOAD HELP DOCUMENTATION
  puts '
   _____ __  ______  _   ______________   _____ ____  __    __________________________
  / ___// / / / __ )/ | / / ____/_  __/  / ___// __ \/ /   /  _/_  __/_  __/ ____/ __ \
  \__ \/ / / / __  /  |/ / __/   / /     \__ \/ /_/ / /    / /  / /   / / / __/ / /_/ /
 ___/ / /_/ / /_/ / /|  / /___  / /     ___/ / ____/ /____/ /  / /   / / / /___/ _, _/
/____/\____/_____/_/ |_/_____/ /_/     /____/_/   /_____/___/ /_/   /_/ /_____/_/ |_|
========================================================================================

HOW TO USE:

$> subnet_split "172.16.0.0/24" 30

172.16.0.0	30	172.16.0.0/30
172.16.0.4	30	172.16.0.4/30
172.16.0.8	30	172.16.0.8/30
...
'
else

  begin
    if (ARGV[1].to_i.to_s === ARGV[1]) then (to_subnet = ARGV[1].to_i) else raise "Invalid to subnet: #{ARGV[1]}" end # Check that the destination subnet size is a number and isn't being mashed by .to_i
    network = IPAddress(ARGV[0]) # Parse the input subnet
    if (network.prefix > to_subnet) then raise "Split size must be smaller than source size" end # Make sure we are actually splititng

    split_number = 2**(to_subnet - network.prefix.to_i) # Calculate split size
    subnets = network.split(split_number) # Splitting magic
    puts "\n"
    subnets.map{|i| puts "#{i.address}\t#{i.prefix}\t#{i.to_string}\n"} # Dump output to screen in format of "Network Address \t Subnet Size \t CIDR Notation"

  rescue => e
    puts "ERROR: #{e}" # Display errors to screen
  end
end
