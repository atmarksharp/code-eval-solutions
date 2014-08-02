OP = /^[+\-*\/]$/
NUM = /^(?:[1-9][0-9]+|[0-9])$/

def calc(op,arg1,arg2)
	res = (
		case op
		when :+
			arg1 + arg2
		when :-
			arg1 - arg2
		when :*
			arg1 * arg2
		when :/
			arg1 / arg2
		end
	)

	return res
end

def parse(terms)
	ops = []
	nums = []

	for s in terms
		if (OP =~ s) == 0
			ops.unshift s.to_sym
		elsif (NUM =~ s) == 0
			nums.push s.to_i
		else
			raise "Parse Error"
		end
	end

	return [ops,nums]
end

def run(context)
	ops,nums = context
	for op in ops
		arg1 = nums.shift.to_f
		arg2 = nums.shift.to_f
		nums.unshift calc(op,arg1,arg2)
	end

	return nums.first.round.to_i
end

File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")
	
	terms = line.split(" ")
	context = parse(terms)
	puts run(context)
end