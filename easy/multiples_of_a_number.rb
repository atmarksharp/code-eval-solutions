File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")
	
    x,n = line.split(",").map{|s| s.to_i}
    puts n*(x/n.to_f).ceil
end