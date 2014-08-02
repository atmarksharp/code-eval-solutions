def int_str?(s)
  Integer(s)
  true
rescue ArgumentError
  false
end

@num = nil
@texts = []

File.open(ARGV[0]).each_line do |line|
	line.delete!("\n")
	
    if int_str?(line)
    	@num = line.to_i
    else
    	@texts.push(line)
    end
end

@longs = @texts.sort_by{|s| s.size}.reverse.take(@num)
@longs.each { |s|
	puts s
}