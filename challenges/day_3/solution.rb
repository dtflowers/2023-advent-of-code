### BEGINNING OF PART 1 SOLUTION ####
lines = File.readlines("test.txt")

# specials = []
# lines.each do |line|
#   characters = line.tr("a-zA-Z", "").tr("0-9", "").tr(".", "").strip.chars.uniq
#   characters.each do |character|
#     specials << character
#   end
# end

# specials = specials.uniq
# pp specials

numbers_coordinates = []
symbol_coordinates = []

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
    elsif length == 1
      # NOTE WE ARE SO CLOSE BUT WE HAVE TO HANDLE THESE MULTIPLE CHARACTERS!!
      symbol = item
      symbol_coordinates << "(#{line.index(symbol)}, #{outer_index})"
    else
      numbers = item.scan(/\d+/)
      symbols = item.scan(/\W/)
      pp symbols
      numbers.each do |number|
        numbers_coordinates << {
          key: number,
          value: number.to_i,
          starting_x_coordinate: line.index(number),
          y_coordinate: outer_index
        }
      end
      symbols.each_with_index do |symbol, inner_index|
        symbol_coordinates << "(#{line.index(symbol) + inner_index}, #{outer_index})"
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

# pp positions

part_numbers = []

positions.each do |position|
  unless (position[:positions].intersection symbol_coordinates).empty?
    part_numbers << position[:value]
  end
end

# pp positions

pp symbol_coordinates

pp part_numbers.sum
