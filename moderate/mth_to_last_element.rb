File.open(ARGV[0]).each_line do |line|
	params = line.split(" ")
	num = params.last.to_i
	puts params.reverse.drop(1)[num-1]
end