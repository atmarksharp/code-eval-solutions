class String
	def drop(n)
		self.split('').drop(n).join
	end

	def take(n)
		self.split('').take(n).join
	end
end

def add_zeros(n,zeros)
	delta = zeros - n.size
	if delta <= 0
		return n
	else
		"0"*delta + n.to_s
	end
end

def my_log2(n)
	if n <= 1
		1
	else
		Math.log2(n)
	end
end

def make_binaries(num)
	m = my_log2(num).ceil
	max = m
	result = []
	for n in (1..max+1).map{|i| ("1"*i).to_i(2) - 1}
		binaries = (0..n).map{|i| add_zeros(i.to_s(2), n.to_s(2).size)}
		result += binaries
	end
	
	return result.take(num)
end

def parse_header(header)
	bin_list = make_binaries(header.size)
	head_list = header.split("")
	hash = {}
	bin_list.each.with_index{|bin,idx| hash[bin] = head_list[idx]}
	hash
end

def parse_body(body,len_count=3)
	next_seg = true
	result = []
	i = 0
	while i < body.size
		s = body.drop(i)

		if s.size == 3 and s.take(len_count).split("").all? {|s| s == "0"}
			# body finished
			return result
		elsif next_seg
			# get length
			count = s.take(len_count).to_i(2)
			next_seg = false
			i += len_count
		
		elsif s.take(count).split("").any? {|s| s == "0"}
			# get args
			result.push s.take(count)
			i += count
		else
			# segment finished
			next_seg = true
			i += count
		end
	end

	# never comes here
	raise "Parse Error"
end

def decode(header,body)
	header_map = parse_header(header)
	binaries = parse_body(body)

	binaries.map{|b| header_map[b]}.join
end

File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")
	m = /^(.+?)(\d+)$/.match(line)
	header = m[1]
	body = m[2]

	puts decode(header,body)
end