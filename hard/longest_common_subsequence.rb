class Array
	def find_all_index(o)
		arr = []
		for i in (0..self.size-1)
			if o == self[i]
				arr.push i
			end
		end
		arr
	end

	def remove_empty()
		arr = self.map{|o| o == [] ? nil : o}.compact
	end

	def remap(arr)
		self.map{|id| arr[id]}
	end
end



def existing_indexes(arr1,arr2)
	arr1.map{|s| arr2.find_all_index s}.remove_empty
end

def make_patterns_impl(arr,result)
	@patterns.push result

	len = arr.size
	for n in (1..len+1)
		target = arr[n-1]
		if target == nil
			# do nothing
		else
			rest = arr.drop(n)
			make_patterns_impl(rest, result + [target])
		end
	end
end

def make_patterns(arr)
	@patterns = []
	make_patterns_impl(arr,[])
	return @patterns.remove_empty.sort
end

def select_continuous(patterns)
	result = []
	for pattern in patterns
		res = [-1]
		for ids in pattern
			id = ids.select{|id| id > res.last}.min
			if id == nil
				res = []
				break
			else
				res.push id
			end
		end
		res = res.drop(1)

		if res.size > 0
			result.push res
		end
	end

	return result
end

def find_lcs(arr1,arr2)
	exist_indexes = existing_indexes(arr1,arr2)
	patterns = make_patterns(exist_indexes)

	common_subseqs_with_id = select_continuous(patterns)
 	common_subseqs = common_subseqs_with_id.map do |a| a.remap(arr2).join end

	lcs = common_subseqs.sort_by{|s| s.size}.last
	return lcs
end



File.open(ARGV[0]).each_line do |line|
	arr1,arr2 = line.split(";").map{|arr| arr.split("")}
	puts find_lcs(arr1,arr2)
end