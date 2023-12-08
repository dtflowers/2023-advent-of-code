
### BEGINNING OF PART 1 SOLUTION ####
input = File.read("input.txt").split("\n").reject { |string| string.empty? }

pattern = input.shift.chars

nodes = input.to_h do |line|
  [
    line.split(" = ").first,
    [line.split(" = ").last.chars[1...4].join, line.split(" = ").last.chars[6...9].join]
  ]
end

previous_node = "AAA"
steps = 0

until previous_node == "ZZZ"
  pattern.each do |move|
    steps += 1
    index = move == "R" ? 1 : 0
    previous_node = nodes[previous_node][index]
  end
end

puts "The answer to part one is #{steps} total steps"
### END OF PART 1 SOLUTION ####
