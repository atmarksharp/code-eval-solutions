File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")
	
    puts line.split(" ").reverse.join(" ")
end