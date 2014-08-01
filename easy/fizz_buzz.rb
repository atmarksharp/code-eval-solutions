File.open(ARGV[0]).each_line do |line|
    args = line.split(" ")
    a = args[0].to_i
    b = args[1].to_i
    n = args[2].to_i
    result = (1..n).map do |i|
        if i % a == 0 and i % b == 0
            "FB"
        elsif i % a == 0
            "F"
        elsif i % b == 0
            "B"
        else
            i.to_s
        end
    end
    
    puts result.join(" ")
end