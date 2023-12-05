require "pry"
### BEGINNING OF PART 1 SOLUTION ####
input = File.read("test.txt")

map = input.split("\n\n").each_with_index.map do |string, index|
  if index == 0
    category = string.split(": ").first
    values = string.split(": ").last.split.map(&:to_i)
  else
    category = string.split("\n").first[0..-6]
    values = string.split("\n").drop(1)
  end
  { category => values }
end

pp map
