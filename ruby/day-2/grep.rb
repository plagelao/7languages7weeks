File.readlines(ARGV[0]).each_with_index do |line, index|
  puts "line #{index+1} - #{line}" if line.include?(ARGV[1])
end
