amount = 1000
max = 10000
arr = [*2..max]

2.upto(max) do |n|
	arr.reject! do |i|
		i != n and i % n == 0
	end
end

puts arr.take(amount).reduce(:+)