### BEGINNING OF PART 1 SOLUTION ####
input = File.read("input.txt")

map = input.split("\n\n").each_with_index.map do |string, index|
  if index == 0
    category = string.split(": ").first
    values = string.split(": ").last.split.map(&:to_i)
  else
    category = string.split("\n").first[0..-6]
    values = string.split("\n").drop(1)
    values.map! do |value|
      range_data = value.split
      {
        destination_start: range_data[0].to_i,
        source_start: range_data[1].to_i,
        length: range_data[2].to_i
      }
    end
  end
  { category => values }
end

seeds = map.shift["seeds"]

lowest_location = nil

seeds.each do |seed|
  previous_value = seed
  map.each do |category|
    category.values.first.detect do |line|
      source_range = (line[:source_start]...(line[:source_start] + line[:length]))
      next unless source_range.include? previous_value

      previous_value = line[:destination_start] + (previous_value - line[:source_start])
    end
  end
  if lowest_location.nil? || previous_value < lowest_location
    lowest_location = previous_value
  end
end

puts "The answer to part one is #{lowest_location}"
### END OF PART 1 SOLUTION ####

### BEGINNING OF PART 2 SOLUTION ####
new_seeds = seeds.each_with_index.map do |seed, index|
  next unless index.even?

  (seed...(seed + seeds[index + 1]))
end.compact

lowest_location = nil
location = 0
loop do
  location += 1
  previous_value = location
  map.reverse.each do |category|
    category.values.first.detect do |line|
      source_range = (line[:destination_start]...(line[:destination_start] + line[:length]))
      in_range = source_range.include? previous_value
      next unless in_range

      previous_value = line[:source_start] + (previous_value - line[:destination_start])
    end
  end
  lowest_location = location
  exists = false
  new_seeds.each do |range|
    exists = range.include? previous_value
    break if exists
  end
  break if exists
end

puts "The solution to part two is #{lowest_location}"
### END OF PART 2 SOLUTION ####
