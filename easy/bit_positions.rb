File.open(ARGV[0]).each_line do |line|
    n,p1,p2 = line.split(",").map{|s| s.to_i}
    bits = n.to_s(2).reverse
    flag = if bits[p1-1] == bits[p2-1] then "true" else "false" end
    puts flag
end