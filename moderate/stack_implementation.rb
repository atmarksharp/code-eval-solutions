File.open(ARGV[0]).each_line do |line|
	stack = line.split(" ").reverse

	pops = stack.select.with_index do |value, index|
		index.even?
	end

	puts pops.join(" ")
end