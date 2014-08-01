def fib(n)
  @cache ||= []
  @cache[n] ||= (
	case n
	when 0 then 0
	when 1 then 1
	else fib(n-2) + fib(n-1)
	end
  )
end

File.open(ARGV[0]).each_line do |line|
    puts fib(line.to_i)
end