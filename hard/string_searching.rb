class String
	def drop(i)
		self.split("").drop(i).join
	end
end

def alphabet?(c)
	"abcdefghijklmnopqrstuvwxyz".include? c.downcase
end

def number?(c)
	"0123456789".include? c
end

def blank?(c)
	" ".include? c
end

def parse(s)
	res = []

	i = 0
	while i < s.size
		c = s[i]

		if alphabet?(c) or number?(c) or blank?(c)
			if res.last != nil and res.last[:type] == :string
				res.last[:content] += c
			else
				res.push( {:type => :string, :content => c} )
			end
		elsif c == "\\" and s[i+1] == "*"
			if res.last != nil and res.last[:type] == :string
				res.last[:content] += "*"
			else
				res.push( {:type => :string, :content => c} )
			end
			i += 1
		elsif c == "*" and s[i+1] != "*"
			res.push( {:type => :wild} )
		else
			raise "Parse Error: \"#{s}\"(#{i})"
		end

		i += 1
	end

	return res
end

def start_with(str,search)
	for i in (0..search.size-1)
		if !(str[i] == search[i])
			return false
		end
	end

	return true
end

def substr_with_index(target_str,search_str)
	for i in (0..target_str.size-1)
		str = target_str.drop(i)
		if start_with(str,search_str)
			return {:result => true, :index => i}
		end
	end

	return {:result => false, :index => nil}
end

def substr?(target_str,search_str)
	substr_with_index(target_str,search_str)[:result]
end

def exec_search(target,search)
	# speed hack
	is_string_only = (search.size == 1 and search[0][:type] == :string)

	if is_string_only
		return substr?(target,search[0][:content])
	else
		# start up fix
		search = search[0][:type] == :wild ? search : [{:type => :wild}] + search

		s = target

		i = 0
		while i < search.size
			cond = search[i]

			if cond[:type] == :string
				if start_with(s,cond[:content])
					s = s.drop(cond[:content].size)
				else
					return false
				end
			elsif cond[:type] == :wild
				_next = search[i+1]

				if _next == nil
					return true
				elsif _next[:type] == :wild
					raise "\"*\" is duplicated: \"#{target}\""
				else
					_result = substr_with_index(s,_next[:content])
					res = _result[:result]
					index = _result[:index]

					if res == true
						s = s.drop(index + _next[:content].size)
						i += 1
					else
						return false
					end
				end
			end

			i += 1
		end

		return true
	end
end

File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")

	target,search_str = line.split(",")
	search = parse(search_str)

	puts (exec_search(target,search) == true ? "true" : "false")
end
