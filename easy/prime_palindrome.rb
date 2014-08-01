max = 1000
arr = [*2..max]

2.upto(max) do |n|
	arr.reject! do |i|
		i != n and i % n == 0
	end
end

palindromes = arr.select do |n|
	n.to_s == n.to_s.reverse
end

puts palindromes.max