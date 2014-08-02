File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")
	
    digits = line.split("").map{|s| s.to_i}
    puts digits.reduce(:+)
end