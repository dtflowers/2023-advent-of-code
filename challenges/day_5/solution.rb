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
