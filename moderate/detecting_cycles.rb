def detect(arr,len)
	range = (-(len-1)..0).to_a.reverse + (1..(len-1)).to_a
	for shift in range
		res = detect_impl(arr,len,shift)
		return res if res != nil
	end

	nil
end

def detect_impl(_arr,len,shift)
	arr = nil
	past = []

	if shift >= 0
		arr = _arr.reverse.drop(shift) + [nil]*shift
	else
		arr = [nil]*-shift + _arr.reverse.drop(-shift)
	end

	for i in (0..(arr.size/len-1))
		cur = arr.drop(i*len).take(len)
		if cur == past
			return cur.reverse
		end
		past = cur
	end

	return nil
end

File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")
	
	arr = line.split(" ")
	for i in (0..arr.size-1)
		res = detect(arr,i)
		if res != nil
			puts res.join(" ")
			break
		end
	end
end