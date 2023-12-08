### BEGINNING OF PART 1 SOLUTION ####
input = File.read("input.txt").split("\n").reject { |string| string.empty? }

pattern = input.shift.chars

nodes = input.to_h do |line|
  [
    line.split(" = ").first,
    [line.split(" = ").last.chars[1...4].join, line.split(" = ").last.chars[6...9].join]
  ]
end

steps = 0
node = "AAA"
until node == "ZZZ"
  pattern.each do |move|
    steps += 1
    index = move == "R" ? 1 : 0
    node = nodes[node][index]
  end
end

puts "The answer to part one is #{steps} total steps"
### END OF PART 1 SOLUTION ####

### BEGINNING OF PART 2 SOLUTION ####
previous_nodes = nodes.keys.select { |e| e.chars.last == "A" }
steps = previous_nodes.map! do |previous_node|
  node_steps = 0
  until previous_node.chars.last == "Z"
    pattern.each do |move|
      node_steps += 1
      index = move == "R" ? 1 : 0
      previous_node = nodes[previous_node][index]
    end
  end
  node_steps
end.reduce(1, :lcm)

puts "The answer to part two is #{steps} total steps"
### END OF PART 2 SOLUTION ####

# ### BEGIN ORIGINAL ATTEMPT AT PART 2 #####
# steps = 0
# previous_nodes = nodes.keys.select { |e| e.chars.last == "A" }
# until previous_nodes.all? { |e| e.chars.last == "Z" }
#   pattern.each do |move|
#     steps += 1
#     index = move == "R" ? 1 : 0
#     previous_nodes.map! do |previous_node|
#       nodes[previous_node][index]
#     end
#   end
# end

# puts "The answer to part two is #{steps} total steps"
# ### END ORIGINAL ATTEMPT AT PART 2 #####
