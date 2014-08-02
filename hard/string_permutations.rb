class String
	def remove_at(n)
		self.split("").map.with_index{|s,i|
			i == n ? nil : s
		}.compact.join
	end
end

def permutations_impl(s,res)
	if s.size == 0
		@permuts.push res.join
		return
	end

	letters = s.split("")
	for i in (0..s.size-1)
		c = letters[i]
		permutations_impl(s.remove_at(i), res+[c])
	end
end

def permutations(s)
	@permuts = []
	permutations_impl(s,[])
	@permuts.sort.join(",")
end

File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")
	
	puts permutations(line)
end