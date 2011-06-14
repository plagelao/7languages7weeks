four = []
(1..16).each do |e| 
  four << e
  if four.size == 4
    puts four.inspect
    four = []
  end
end
