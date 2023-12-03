### BEGINNING OF PART 1 SOLUTION ####
lines = File.readlines("input.txt")

numbers_coordinates = []
lines.each_with_index do |line, outer_index|
  items = line.strip.split(".")
  items.reject!(&:empty?) if items.count > 1
  items.each do |item|
    length = item.length
    is_number = item.scan(/\W/).empty?
    if is_number
      numbers_coordinates << {
        key: item,
        value: item.to_i,
        starting_x_coordinate: line.index(item),
        y_coordinate: outer_index
      }
      line[line.index(item)...(line.index(item) + item.length)] =
        case item.length
        when 1
          "x"
        when 2
          "xx"
        when 3
          "xxx"
        when 4
          "xxxx"
        when 5
          "xxxxx"
        end
    elsif length > 1
      numbers = item.scan(/\d+/)
      numbers.each do |number|
        numbers_coordinates << {
          key: number,
          value: number.to_i,
          starting_x_coordinate: line.index(number),
          y_coordinate: outer_index
        }
        line[line.index(number)...(line.index(number) + number.length)] =
          case number.length
          when 1
            "x"
          when 2
            "xx"
          when 3
            "xxx"
          when 4
            "xxxx"
          when 5
            "xxxxx"
          end
      end
    end
  end
end

positions = numbers_coordinates.each.map do |number_coordinates|
  adjacent_positions = []
  number_coordinates[:key].chars.each_with_index do |_digit, index|
    position = "(#{number_coordinates[:starting_x_coordinate] + index}, #{number_coordinates[:y_coordinate]})"
    coordinates = position.scan(/\d+/)
    x = coordinates.first.to_i
    y = coordinates.last.to_i
    adjacent_positions << position
    adjacent_positions << "(#{x - 1}, #{y})"
    adjacent_positions << "(#{x - 1}, #{y - 1})"
    adjacent_positions << "(#{x}, #{y - 1})"
    adjacent_positions << "(#{x}, #{y + 1})"
    adjacent_positions << "(#{x - 1}, #{y + 1})"
    adjacent_positions << "(#{x + 1}, #{y})"
    adjacent_positions << "(#{x + 1}, #{y - 1})"
    adjacent_positions << "(#{x + 1}, #{y + 1})"
  end
  { value: number_coordinates[:value], positions: adjacent_positions.uniq }
end

symbol_coordinates = []
lines.each_with_index do |line, y|
  line.strip.chars.each_with_index do |char, x|
    is_special = !char.scan(/\W/).reject { |c| c.strip == "." }.empty?
    symbol_coordinates << "(#{x}, #{y})" if is_special
  end
end

part_numbers = []
positions.each do |position|
  unless (position[:positions].intersection symbol_coordinates).empty?
    part_numbers << position[:value]
  end
end

solution = part_numbers.sum

puts "The solution to part one is #{solution}"
### END OF PART 1 SOLUTION ####

### BEGINNING OF PART 2 SOLUTION ####
asterisk_coordinates = []
lines.each_with_index do |line, y|
  line.strip.chars.each_with_index do |char, x|
    is_asterisk = char == "*"
    next unless is_asterisk

    asterisk_coordinates << {
      coordinates: "(#{x}, #{y})",
      count: 0,
      ratio: 1
    }
  end
end

positions.each do |position|
  asterisk_coordinates.each do |asterisk|
    is_adjacent = position[:positions].include? asterisk[:coordinates]
    next unless is_adjacent

    asterisk[:count] += 1
    asterisk[:ratio] = asterisk[:ratio] * position[:value]
  end
end

gear_ratios = asterisk_coordinates.map do |asterisk|
  if asterisk[:count] > 1
    asterisk[:ratio]
  else
    0
  end
end

solution = gear_ratios.sum

puts "The solution to part two is #{solution}"
### END OF PART 2 SOLUTION ####
